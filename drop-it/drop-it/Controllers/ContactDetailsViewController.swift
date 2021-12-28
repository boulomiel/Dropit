//
//  ContactDetailsViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

class ContactDetailsViewController : UIViewController, DropStoryboarded{
    
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressButtonOutlet: UIButton!
    lazy var dropViewModel =  DropViewModel(API())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        configure()
        setupViewModel()
    }
    
    func setupViewModel(){
        dropViewModel.getUser {[weak self] user in
            DispatchQueue.main.async {
                if let user = user {
                    self?.fullNameTextField.text = user.fullName
                    self?.phoneNumberTextField.text = user.phoneNumber.number
                }
            }
        } _: { isUpdated in
            if let isUpdated = isUpdated, isUpdated{
                DispatchQueue.main.async {[weak self] in
                    if let self = self{
                        Router.showAdressViewController(self.dropViewModel)
                    }
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dropViewModel.disableUpdate()
    }
    
    private func configureNavbar(){
        setupTitle("Contact Details")
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configure(){
        infoContainer.setRoundCorners()
        infoContainer.shadeView()
        addressButtonOutlet.shadeView()
    }
    
    @IBAction func AddressButtonAction(_ sender: Any) {
        guard let username = fullNameTextField.text, username.count > 3 else {return}
        guard let phonenumber = phoneNumberTextField.text, username.count > 3 else {return}
        let user = User(fullName: username, phoneNumber: PhoneNumber(countryCode: 40, number: phonenumber))
        dropViewModel.updateUser(user: user)
    }
    
}
