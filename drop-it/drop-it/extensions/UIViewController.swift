//
//  UIViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

extension UIViewController{
    func setupTitle(_ title : String){
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
