//
//  CompleteProfileWorker.swift
//  ReceiptBot
//
//  Created by Haik Ampardjian on 4/8/17.
//  Copyright (c) 2017 receiptbot. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

class CompleteProfileWorker {
    let params: CompleteProfile.Registration.Params
    
    /// TODO: replace all those params into struct
    init(params: CompleteProfile.Registration.Params) {
        self.params = params
    }
    
    func completeRegistration(callback: @escaping (RebotValueWrapper<AuthResponse>) -> ()) {
        AuthResponse.loadType(request: API.signUpSecond(params.params)) { (auth, message) in
            guard message == nil else { callback(.none(message: message!)); return }
            guard auth!.detail.isEmpty else { callback(.none(message: auth!.detail)); return }
            
            /// Save the response into database
            let _: UserInfo = DatabaseManager.shared.insert(response: auth!)
            
            /// Save the user info into singleton
            AppSettings.shared.store(user: auth!)
            
            callback(.value(auth!))
        }
    }
}
