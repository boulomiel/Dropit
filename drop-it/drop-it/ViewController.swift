//
//  ViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        API.shared.start(User.self, request: RequestType.getContactDetails.request) { result in
            switch result{
            case .success(let user):
                print(user.toDict())
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
 //       DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           // Router.showContactDetailsViewController()
//        }

    }


}

