//
//  PhotoVerifyViewController.swift
//  ReceiptBot
//
//  Created by Haik Ampardjian on 4/13/17.
//  Copyright (c) 2017 receiptbot. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol PhotoVerifyViewControllerOutput {
    func tryToUpload(request: PhotoVerify.Upload.Request)
}

class PhotoVerifyViewController: UIViewController {
    var output: PhotoVerifyViewControllerOutput!
    var router: PhotoVerifyRouter!
    
    var takenPhoto: UIImage!

    @IBOutlet weak var photo: UIImageView!
    
    @IBAction func backToCamera(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadPhoto(_ sender: UIButton) {
        tryToUpload()
    }
    
    // MARK: - Object lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoVerifyConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
    }

    // MARK: - Event handling
    func setupOnLoad() {
        photo.image = takenPhoto
    }
    
    func tryToUpload() {
        let request = PhotoVerify.Upload.Request(image: takenPhoto)
        output.tryToUpload(request: request)
    }

    // MARK: - Display logic
    func displayInvoices() {
        router.navigateToInvoice()
    }
}
