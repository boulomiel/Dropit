//
//  ReviewViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

class ReviewViewController : UIViewController, DropStoryboarded{
    
    @IBOutlet weak var finalTableView: UITableView!
    lazy var dropViewModel = DropViewModel()
    var tableReviewData =  [[Any]]()
    let titles = [Constants.contactsDetais, Constants.addressDetails, Constants.choosenBags]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dropViewModel.start { result in
            DispatchQueue.main.async {[weak self] in 
                self?.tableReviewData = result
                self?.finalTableView.reloadData()
            }
        } _: { isAccepted in
            DispatchQueue.main.async {
                Router.showResultViewController()
            }
        }
    }
    
    private func configureTableView(){
        finalTableView.delegate = self
        finalTableView.dataSource = self
        finalTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func configureNavbar(){
        setupTitle(Constants.review)
        setupBackButton()
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        dropViewModel.update()
    }
}

extension ReviewViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableReviewData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: tableView.frame.width , height: 50)
        label.text = titles[section]
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        return label
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableReviewData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)!
        cell.textLabel?.text = String(describing: tableReviewData[indexPath.section][indexPath.row])
        return cell
    }    
}

