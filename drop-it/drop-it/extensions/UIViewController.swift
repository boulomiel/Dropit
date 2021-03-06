//
//  UIViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

extension UIViewController{
    func setupTitle(_ title : String?){
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupBackButton(){
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .black
    }
    
    func resignKeyboard(){
        let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(resignKeyBoardSelector(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func resignKeyBoardSelector(_ sender : UITapGestureRecognizer){
        self.view.endEditing(true)
    }
}
