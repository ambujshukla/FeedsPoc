//
//  FeedsPocTests.swift
//  FeedsPocTests
//
//  Created by Ambuj Shukla on 23/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import XCTest
@testable import FeedsPoc

private let kIncorrect_BaseUrl = "https://dl.dropboxusercontents.com/s/2iodh4vg0eortkl/facts.json"

class FeedsPocTests: XCTestCase {
    
    var feedsViewController: FeedsViewController?
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
        feedsViewController = FeedsViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
        feedsViewController = nil
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
    
    func testHelloWorld() {
        var helloWorld: String?
        XCTAssertNil(helloWorld)
    }
    
    
    func testHelloWorldFail() {
        var helloWorld: String?
        helloWorld = "hello world"
        XCTAssertEqual(helloWorld, "hellow world1")
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidCallToGetFeedsHTTPStatusCode200() {
        // given
        let url = URL(string: kBaseUrl)
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // Asynchronous test: faster fail
    func testValidCallToGetFeedsHTTPStatusCode200Fail() {
        // given
        let url = URL(string: kIncorrect_BaseUrl)
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }
}
