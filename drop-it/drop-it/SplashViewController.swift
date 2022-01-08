//
//  ViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import UIKit

class SplashViewController: UIViewController {
    
    lazy var splashViewModel =  SplashViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        splashViewModel.start(false) { isDone in
            Router.showContactDetailsViewController()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        pullBaseData()
        splashViewModel.observable.value = true
    }
    
    private func pullBaseData(){
        let operationQueue =  OperationQueue()
        let userOperation =  NetworkOperation(data: User.self, requestType: .getContactDetails)
        let addressOperation =  NetworkOperation(data: Address.self, requestType: .getShippingAddress)
        addressOperation.addDependency(userOperation)
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperation(userOperation)
        operationQueue.addOperation(addressOperation)
        operationQueue.waitUntilAllOperationsAreFinished()
    }
}

    
