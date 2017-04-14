//
//  DetailInvoiceInteractor.swift
//  ReceiptBot
//
//  Created by Haik Ampardjian on 4/13/17.
//  Copyright (c) 2017 receiptbot. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol DetailInvoiceInteractorOutput {
    func presentInitialSetup(response: DetailInvoice.Setup.Response)
    func presentSave(response: DetailInvoice.Save.Response)
}

class DetailInvoiceInteractor {
    var output: DetailInvoiceInteractorOutput!
    
    var originalInvoice: SyncConvertedInvoiceResponse?

    // MARK: - Business logic
    func initialSetup() {
        let response = DetailInvoice.Setup.Response(with: originalInvoice)
        output.presentInitialSetup(response: response)
    }
    
    func save(request: DetailInvoice.Save.Request) {
        let category = request.category ?? ""
        let categoryIndex = DetailInvoicePickerValues.Category.values.index(of: category) ?? 0
        let categoryId = String(categoryIndex)
        
        let param = DetailInvoice.Save.Params(status: "Approved",
                                              convertedInvoiceId: originalInvoice?.convertedInvoiceId ?? "1",
                                              dueDate: request.dueDate ?? "",
                                              entityId: originalInvoice?.entityId ?? "",
                                              fileName: originalInvoice?.fileName ?? "",
                                              grossNumber: request.grossAmount ?? "",
                                              invoiceNumber: request.invoiceNumber ?? "",
                                              invoicedateMobile: request.invoiceDate ?? "",
                                              netAmount: request.netAmount ?? "",
                                              originalInvoiceId: originalInvoice?.originalInvoiceId ?? "",
                                              originalFileName: originalInvoice?.originalFileName ?? "",
                                              supplierName: request.supplierName ?? "",
                                              taxAmount: request.taxAmount ?? "",
                                              taxPercentage: originalInvoice?.taxPercentage ?? "",
                                              paymentMethod: request.paymentMethod ?? "",
                                              categoryId: categoryId)
        
        let worker = DetailInvoiceSaveWorker(params: param.params)
        worker.save { [weak self] (inv) in
            DispatchQueue.main.async { self?.pass(data: inv) }
        }
    }
    
    func reject() {
        
    }
    
    func pass(data: RebotValueWrapper<SyncConvertedInvoiceResponse>) {
        let response = DetailInvoice.Save.Response(data: data)
        output.presentSave(response: response)
    }
}
