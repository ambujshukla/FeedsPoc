//
//  FeedsViewController.swift
//  FeedsPoc
//
//  Created by Ambuj Shukla on 23/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import UIKit

private let cellIdentifier = "feedsTableViewCell"

class FeedsViewController: UIViewController {
    
    //MARK: Private
    private var feedsViewModel = FeedsViewModel()
    private var tblView: UITableView!
    
    //MARK: Adding refreshControl to show while pull to refresh.
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FeedsViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.getFeeds()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tblView.frame = view.bounds
    }
    
    //MARK: Private methods
    
    func getFeeds() {
        self.feedsViewModel.getFeedsData { (feedsModel) in
            if (feedsModel.rows?.count)! > 0 {
                self.feedsViewModel.feedsData = feedsModel
                self.tblView.reloadData()
            }
            if let title = self.feedsViewModel.feedsData.title {
                self.title = title
            }
        }
        self.refreshControl.endRefreshing()
    }
    
    /* This will style the tableview with the initial configurations
     */
    func configureTableView(){
        self.tblView = UITableView(frame: view.bounds, style: .plain)
        self.tblView.register(FeedsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.tableFooterView = UIView()
        self.view.addSubview(self.tblView)
        self.tblView.addSubview(self.refreshControl)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.getFeeds()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: UITableView DataSources & Delegates

extension FeedsViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let totalRows = self.feedsViewModel.feedsData.rows else {
            return 0
        }
        return totalRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FeedsTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        cell.styleUI(rowModel: self.feedsViewModel.feedsData.rows![indexPath.row])
        return cell
    }
}
