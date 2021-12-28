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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        configure()
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
        Router.showAdressViewController()
    }
    
}
