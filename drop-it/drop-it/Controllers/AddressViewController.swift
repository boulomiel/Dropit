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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        configure()
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
        Router.showDropBagsViewController()
    }
    
    
}

