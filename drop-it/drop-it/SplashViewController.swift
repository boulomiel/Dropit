//
//  ViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            Router.showContactDetailsViewController()
        }
    }
}

