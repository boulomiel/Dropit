//
//  ResultViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

class ResultViewController : UIViewController, DropStoryboarded{
    
    @IBOutlet weak var successImage: UIImageView!{
        didSet{
            successImage.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        successImage.scaleWithAnimation(value: 1,completion: nil)
        configureNavbar()
    }
    
    private func configureNavbar(){
        setupTitle(nil)
        setupBackButton()
    }
}

