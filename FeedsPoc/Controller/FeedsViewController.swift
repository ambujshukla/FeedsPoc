//
//  FeedsViewController.swift
//  FeedsPoc
//
//  Created by Ambuj Shukla on 23/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import UIKit

class FeedsViewController: UIViewController {
    
    var feedsViewModel = FeedsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedsViewModel.getFeedsData { (feedsModel) in

        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
