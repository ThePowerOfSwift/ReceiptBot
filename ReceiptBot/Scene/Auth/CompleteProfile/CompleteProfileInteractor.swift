//
//  CompleteProfileInteractor.swift
//  ReceiptBot
//
//  Created by Haik Ampardjian on 4/8/17.
//  Copyright (c) 2017 receiptbot. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

enum CompleteProfileType: String {
    case system
    case external
}

protocol CompleteProfileInteractorOutput {
      func presentAuthResponse(response: CompleteProfile.Registration.Response)
}

class CompleteProfileInteractor {
    var output: CompleteProfileInteractorOutput!
    var worker: CompleteProfileWorker!
    
    var email: String!
    var type: CompleteProfileType = .system
    
    /// In case of external sign in
    var externalInfo: SignIn.CompleteProfileInfo!
    
    /// Properties from pickers
    var countryId = 0
    var accountType = 0
    
    var countries: [String] {
        return [
            "Choose Country",
            "United Kingdom"
        ]
    }
    
    var roles: [String] {
        return [
            "Choose Account Type",
            "Accountant",
            "BookKeeper",
            "Enterpreneur",
            "Finance Professional",
            "Other",
            "StartUp"
        ]
    }

    // MARK: - Business logic
    func completeRegistration(request: CompleteProfile.Registration.Request) {
        guard countryId != 0 else { pass(user: .none(message: "Pick the country!")); return }
        guard accountType != 0 else { pass(user: .none(message: "Pick the account type!")); return }
        guard !request.fullName.isEmpty else { pass(user: .none(message: "Enter Full Name!")); return }
        guard !request.companyName.isEmpty else { pass(user: .none(message: "Enter Organisation Name!")); return }
        
        let parameters = params(from: request)
        worker = CompleteProfileWorker(params: parameters)
        worker.completeRegistration { [weak self] (wrapper) in
            DispatchQueue.main.async {
                if self?.type == .system { self?.pass(user: wrapper) }
                else { self?.tryExternalLogin() }
            }
        }
    }
    
    func tryExternalLogin() {
        let extWorker = ExternalLoginWorker(email: externalInfo.email)
        extWorker.tryToLogin { [weak self] (resp) in
            DispatchQueue.main.async { self?.pass(user: resp) }
        }
    }
    
    func params(from request: CompleteProfile.Registration.Request) -> CompleteProfile.Registration.Params {
        let parameters = CompleteProfile.Registration.Params(fullName: request.fullName,
                                                             companyName: request.companyName,
                                                             countryId: countryId,
                                                             accType: accountType,
                                                             email: email,
                                                             userType: 1) /// Android sets userType to 1
        return parameters
    }
    
    func pass(user: RebotValueWrapper<AuthResponse>) {
        let response = CompleteProfile.Registration.Response(data: user)
        output.presentAuthResponse(response: response)
    }
}
