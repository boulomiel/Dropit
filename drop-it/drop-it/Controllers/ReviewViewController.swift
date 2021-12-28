//
//  ReviewViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

class ReviewViewController : UIViewController, DropStoryboarded{
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var streesAddressLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var bagsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        configureTableView()
    }
    
    private func configureTableView(){
        bagsTableView.delegate = self
        bagsTableView.dataSource = self
        bagsTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func configureNavbar(){
        setupTitle("Review")
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}


extension ReviewViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

