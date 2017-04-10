//
//  SignInPresenter.swift
//  ReceiptBot
//
//  Created by Haik Ampardjian on 4/8/17.
//  Copyright (c) 2017 receiptbot. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol SignInPresenterOutput: class, Errorable, Spinnable {
    func displayMain()
}

class SignInPresenter {
    weak var output: SignInPresenterOutput!

    // MARK: - Presentation logic

    func presentLogin(response: SignIn.Login.Response) {
        output.stopSpinning()
        
        switch response.data {
        case .none(let message): output.show(type: .error(message: message))
        case .value: output.displayMain()
        }
    }
}