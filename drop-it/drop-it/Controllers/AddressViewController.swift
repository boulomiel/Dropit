//
//  AdressViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

class AddressViewController : UIViewController, DropStoryboarded{
    
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var streetnameTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var countryTextfield: UITextField!
    @IBOutlet weak var bagsButtonOutlet: UIButton!
    var dropViewModel : DropViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        configure()
        setupViewModel()
    }
    
    private func setupViewModel(){
        dropViewModel.getAddress { address in
            DispatchQueue.main.async {[weak self] in
                if let address = address{
                    self?.streetnameTextfield.text = address.streetAddress
                    self?.cityTextfield.text = address.city
                    self?.countryTextfield.text = address.country
                }
            }
        } _: { isUpdated in
            if let isUpdated =  isUpdated, isUpdated{
                DispatchQueue.main.async {[weak self] in
                    if let self = self{
                        Router.showDropBagsViewController(self.dropViewModel)
                    }
                }
            }
        }
    }
    
    private func configureNavbar(){
        setupTitle("Address Details")
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
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
        dropViewModel.updateAddress(address: Address(streetAddress: street, city: city, country: country))
    }
    
    
}

