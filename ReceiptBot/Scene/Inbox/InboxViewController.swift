//
//  InboxViewController.swift
//  ReceiptBot
//
//  Created by Haik Ampardjian on 4/5/17.
//  Copyright (c) 2017 receiptbot. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import XLPagerTabStrip

protocol InboxViewControllerOutput {
//    func fetchInbox(request: Inbox.DataSource.Request)
}

class InboxViewController: UIViewController {
    private var dataSource: InboxDataSource!
    
    var output: InboxViewControllerOutput!
    var router: InboxRouter!

    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBActions
    
    @IBAction func pickFilter(_ sender: UIButton) {
    }
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        InboxConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Event handling
    
    func setupTableView() {
        tableView.register(InboxCell.nib, forCellReuseIdentifier: InboxCell.cellId)
        
        dataSource = InboxDataSource()
        dataSource.vcOutput = self
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }

    // MARK: - Display logic

    func displaySomething(viewModel: Inbox) {
        // NOTE: Display the result from the Presenter

        // nameTextField.text = viewModel.name
    }
}

extension InboxViewController: InboxDataSourceVCOutput {
    func finishUpdatingTableView() {
        tableView.reloadData()
    }
    
    func startUpdatingTableView() {
        
    }
}

extension InboxViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: " Inbox  ")
    }
}