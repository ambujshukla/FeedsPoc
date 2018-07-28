//
//  FeedsPocTests.swift
//  FeedsPocTests
//
//  Created by Ambuj Shukla on 23/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import XCTest
import ObjectMapper
import Alamofire
import Mockingjay

@testable import FeedsPoc

private let kIncorrect_BaseUrl = "https://dl.dropboxusercontents.com/s/2iodh4vg0eortkl/facts.json"

private let kBaseUrl_WithIdInResponse = "http://www.json-generator.com/api/json/get/cevhStWZFe?indent=2" //This is a clone for the given service to check with the wrong data type for id parameter in model class.

private let kBaseUrl_WithIncorrectKey = "http://www.json-generator.com/api/json/get/cgkUoLnILC?indent=2" //This is a clone for the given service to check with the wrong key for the rows.

private let kBaseUrl_WithIncorrectJsonData = "http://www.json-generator.com/api/json/get/cgkUoLnILC?indent"

enum Error: Int {
    case notFoundError = 404
}

class FeedsPocTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    var feedsViewModel: FeedsViewModel?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
        feedsViewModel = FeedsViewModel()
        
        let notFoundStub = http(Error.notFoundError.rawValue, download: nil)

        //Below are for creating stubs
        //For the json with proper data
        do {
            if let file = Bundle.main.url(forResource: "FeedsData", withExtension: "json") {
                let data = try Data(contentsOf: file)
                stub(uri(kBaseUrl), jsonData(data as Data))
            }
        }catch {
            print("Not able to convert to data")
        }
        
        //For the file which is not present in bundle
        if let _ = Bundle.main.url(forResource: "InvalidUrl", withExtension: "json") {
        } else {
            stub(uri(kIncorrect_BaseUrl), notFoundStub)
            print("File not found")
        }
        
        do {
            if let file = Bundle.main.url(forResource: "FeedsInvalidData", withExtension: "json") {
                let data = try Data(contentsOf: file)
                stub(uri(kBaseUrl_WithIncorrectJsonData), jsonData(data as Data))
            }
        }catch {
            print("Not able to convert to data")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //This is the unit test for the successful finding of the file in the bundle and stup works properly.
    func testValidCallToGetFeedsHTTPStatusCode200() {
        let url = URL(string: kBaseUrl)
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //This is the unit test when the url not found means the file not found which we were using for stub.
    func testValidCallToGetFeedsHTTPStatusCode200Fail() {
        let url = URL(string: kIncorrect_BaseUrl)
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //In this we need to refractor code as invalid json will going to crash the code
    func testCallToMapObjectsWithIncorrectJsonFormat() {
        let promise = expectation(description: "proper json data")
        ApiManager.sharedInstance.callService(url: kBaseUrl_WithIncorrectJsonData, parameters: [:], completion: { (responseData) in
            if let dict = self.feedsViewModel?.convertToDictionary(text: responseData.result.value!) {
                promise.fulfill()
                if let resultData = Mapper<FeedsModelTest>().map(JSON: dict){
                    print(resultData)
                }
            }else {
                XCTFail("coming json is not in proper format")
            }
        }) { (error) in
            
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    //In this test the key "id" is of string type but the stub data is giving integer type, so this will not going to map id key and it's value always be nil.
    func testCallToMapObjectsWithWrongDataTypeInModel() {
        let promise = expectation(description: "id in model must not be nil")
        ApiManager.sharedInstance.callService(url: kBaseUrl_WithIdInResponse, parameters: [:], completion: { (responseData) in
            if let resultData = Mapper<FeedsModelTest>().map(JSON: (self.feedsViewModel?.convertToDictionary(text: responseData.result.value!)!)! ){
                if (resultData.rows?.count)! > 0 {
                    let rowsData = resultData.rows![0]
                    if rowsData.id == nil {
                        XCTFail("not map id parameter due to wrong datatype")
                    }else {
                        promise.fulfill()
                    }
                }else {
                    XCTFail("rows data are not available")
                }
                print(resultData)
            }
        }) { (error) in
            
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    //This test will going to perform for the key row as this will going to fail as the key to map is rows but stub is giving row.
    func testCallToMapObjectsWithWrongKey() {
        let promise = expectation(description: "key is different for rows so must go in to fail case")
        ApiManager.sharedInstance.callService(url: kBaseUrl_WithIncorrectKey, parameters: [:], completion: { (responseData) in
            let resultData = Mapper<FeedsModelTest>().map(JSON: (self.feedsViewModel?.convertToDictionary(text: responseData.result.value!)!)!)
            if resultData?.rows != nil {
                promise.fulfill()
            }else {
                XCTFail("Object mapper is unable to parse the given response for the key rows, title gets parsed")
            }
        }) { (error) in
            
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    //Positive scanrio for String to Dictionary conversion
    func testStringToDictionaryConversionPositiveTest() {
        let promise = expectation(description: "String is properly converted to dictionary")
        if let _ = feedsViewModel?.convertToDictionary(text: "{\"first_name\":\"Ambuj\"}")
        {
            promise.fulfill()
        }else {
            XCTFail("Conversion fails")
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //Negative scanrio for String to Dictionary conversion
    func testStringToDictionaryConversionNegativeTest() {
        let promise = expectation(description: "String is properly converted to dictionary")
        if let _ = feedsViewModel?.convertToDictionary(text: "{ambuj}")
        {
            promise.fulfill()
        }else {
            XCTFail("Conversion fails")
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
