//
//  SlideMenuConfigurator.swift
//  ReceiptBot
//
//  Created by Haik Ampardjian on 3/28/17.
//  Copyright (c) 2017 receiptbot. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import SlideMenuControllerSwift

final class SlideMenuConfigurator {
    static let sharedInstance = SlideMenuConfigurator()
    private let sideMenuWidth: CGFloat = 0.87

    private init() {}

    // MARK: - Configuration

    func configure(viewController: SlideMenuViewController) {
        let screenWidth = UIScreen.main.bounds.width
        let sideViewWidth = screenWidth * sideMenuWidth
        
        SlideMenuOptions.contentViewScale = 1.0
        SlideMenuOptions.contentViewDrag = true
        SlideMenuOptions.leftViewWidth = sideViewWidth
        SlideMenuOptions.rightViewWidth = sideViewWidth
        SlideMenuOptions.simultaneousGestureRecognizers = false
        SlideMenuOptions.hideStatusBar = false
        
        if let main = UIStoryboard(name: "InvoicesAndReceipts", bundle: Bundle.main).instantiateInitialViewController() {
            viewController.mainViewController = main
        }
        
        if let left = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LeftViewController") as? LeftViewController {
            viewController.leftViewController = left
        }
    }
}
