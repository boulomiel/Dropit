//
//  ContactDetailsViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

class ContactDetailsViewController : TextFieldHolderViewController, DropStoryboarded{
    
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressButtonOutlet: UIButton!
    lazy var contactViewModel = ContactViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        configure()
        setupViewModel()
        resignKeyboard()
        setupTextFieldDelegate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        contactViewModel.disableUpdate()
    }
    
    private func setupTextFieldDelegate(){
        fullNameTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    private func setupViewModel(){
        contactViewModel.bind { user in
            DispatchQueue.main.async {[weak self] in
                if let user = user {
                    self?.fullNameTextField.text = user.fullName
                    self?.phoneNumberTextField.text = user.phoneNumber.number
                }
            }
        } _: { isUpdated in
            if let isUpdated = isUpdated, isUpdated{
                Router.showAdressViewController()
            }
        }
    }
    
    private func configureNavbar(){
        setupTitle(Constants.contactsDetais)
        navigationItem.setHidesBackButton(true, animated: false)
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
        contactViewModel.update(user: user)
    }
    
}
