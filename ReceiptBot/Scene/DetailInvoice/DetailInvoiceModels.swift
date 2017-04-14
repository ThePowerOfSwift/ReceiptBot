//
//  DetailInvoiceModels.swift
//  ReceiptBot
//
//  Created by Haik Ampardjian on 4/13/17.
//  Copyright (c) 2017 receiptbot. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

struct DetailInvoice {
    struct Setup {
        struct Response {
            let invoice: RebotValueWrapper<SyncConvertedInvoiceResponse>
            
            init (with invoice: SyncConvertedInvoiceResponse?) {
                if let unwrappedInvoice = invoice { self.invoice = .value(unwrappedInvoice) }
                else { self.invoice = .none(message: "No original invoice") }
            }
        }
        
        struct ViewModel {
            let imageRequest: URLRequest
            let supplierName: String
            let invoiceDate: String
            let invoiceNumber: String
            let paymentMethod: String
            let category: String
            let taxRate: String
            let taxAmount: String
            let grossAmount: String
            let netAmount: String
            let dueDate: String
        }
    }
    
    struct Save {
        struct Request {
            
        }
        
        struct Response {
            
        }
    }
}
