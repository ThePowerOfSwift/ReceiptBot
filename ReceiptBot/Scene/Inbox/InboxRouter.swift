//
//  InboxRouter.swift
//  ReceiptBot
//
//  Created by Haik Ampardjian on 4/5/17.
//  Copyright (c) 2017 receiptbot. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol InboxRouterInput {
    func navigateToDetails()
}

class InboxRouter: InboxRouterInput {
    weak var viewController: InboxViewController!

    // MARK: - Navigation

    func navigateToDetails() {
         viewController.performSegue(withIdentifier: "ShowDetailView", sender: nil)
    }

    // MARK: - Communication

    func passDataToNextScene(segue: UIStoryboardSegue) {
        if segue.identifier == "ShowDetailView" {
            passDataToDetailInvoiceScene(segue: segue)
        }
    }

    func passDataToDetailInvoiceScene(segue: UIStoryboardSegue) {
        let details = segue.destination as! DetailInvoiceViewController
        details.output.originalInvoice = viewController.output.selectedInvoice
    }
}
