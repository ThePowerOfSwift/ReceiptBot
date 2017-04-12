//
//  PhotoVerifyModels.swift
//  ReceiptBot
//
//  Created by Haik Ampardjian on 4/13/17.
//  Copyright (c) 2017 receiptbot. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

struct PhotoVerify {
    struct Upload {
        struct Request {
            let image: UIImage!
        }
        
        struct Response {
            let data: RebotValueWrapper<FileUploadResponse>
        }
        
        struct Params {
            let userInfo: UserInfo
            let imgString: String
            let invoiceInfo: Invoice
        }
    }
}