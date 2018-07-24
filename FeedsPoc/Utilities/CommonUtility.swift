//
//  CommonUtility.swift
//  FeedsPoc
//
//  Created by Ambuj Shukla on 25/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import CRNotifications

private let kActivityIndicatorWidth: CGFloat = 100.0
private let kActivityIndicatorHeight: CGFloat = 100.0

class CommonUtility: NSObject, NVActivityIndicatorViewable {
    
    /**
     *  It will show loading mask.
     */
    
    class func startLoader() {
        let activityData = ActivityData(size: CGSize(width: kActivityIndicatorWidth, height: kActivityIndicatorHeight), message: "", messageFont: UIFont.systemFont(ofSize: FONT_SIZE_16), messageSpacing: 0, type: .ballRotateChase, color: UIColor.gray, padding: 0, displayTimeThreshold: 3, minimumDisplayTime: 1, backgroundColor:  UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), textColor: UIColor.gray)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    /**
     *  It will hide loading mask.
     */
    class func stopLoader() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
