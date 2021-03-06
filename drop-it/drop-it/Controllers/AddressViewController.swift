//
//  AdressViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

class AddressViewController : TextFieldHolderViewController, DropStoryboarded{
    
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var streetnameTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var countryTextfield: UITextField!
    @IBOutlet weak var bagsButtonOutlet: UIButton!
    lazy var addressViewModel : AddressViewModel = {
        return AddressViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        configure()
        setupViewModel()
        resignKeyboard()
        setupTextfieldsDelegate()
    }
    
    private func setupViewModel(){
        addressViewModel.start { address in
            DispatchQueue.main.async {[weak self] in
                if let address = address{
                    self?.streetnameTextfield.text = address.streetAddress
                    self?.cityTextfield.text = address.city
                    self?.countryTextfield.text = address.country
                }
            }
        } _: { isUpdated in
            if let isUpdated =  isUpdated, isUpdated{
                Router.showDropBagsViewController()
            }
        }
    }
    
    private func setupTextfieldsDelegate(){
        streetnameTextfield.delegate =  self
        cityTextfield.delegate = self
        countryTextfield.delegate = self
    }
    
    private func configureNavbar(){
        setupTitle(Constants.addressDetails)
        setupBackButton()
    }
    
    private func configure(){
        infoContainer.setRoundCorners()
        infoContainer.shadeView()
        bagsButtonOutlet.shadeView()
    }
    
    @IBAction func bagsButtonAction(_ sender: Any) {
        guard let street = streetnameTextfield.text , street.count > 0 else {
            print("no street inserted")
            return
        }
        guard let city = cityTextfield.text, city.count > 0 else {
            print("no city inserted")
            return
        }
        
        guard let country = countryTextfield.text, country.count > 0 else {
            print("no country inserted")
            return
        }
        addressViewModel.update(Address(streetAddress: street, city: city, country: country))
    }
}

