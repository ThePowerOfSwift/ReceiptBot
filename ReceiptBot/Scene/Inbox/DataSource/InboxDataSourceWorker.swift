//
//  InboxDataSourceWorker.swift
//  ReceiptBot
//
//  Created by Haik Ampardjian on 4/7/17.
//  Copyright (c) 2017 receiptbot. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

class InboxDataSourceWorker {
    let entityId: Int
    
    init(entityId: Int) {
        self.entityId = entityId
    }
    
    func fetchInvoices(callback: @escaping (RebotValueWrapper<[SyncConvertedInvoiceResponse]>) -> ()) {
        SyncConvertedInvoiceResponse.load(request: API.syncData(with: entityId)) { (invoicesResp, message) in
            guard message == nil else { callback(.none(message: message!)); return }
            guard let invoices = invoicesResp else { callback(.none(message: "Can't parse Sync Invoices Data!")); return }
            
            callback(.value(invoices))
        }
    }
}
