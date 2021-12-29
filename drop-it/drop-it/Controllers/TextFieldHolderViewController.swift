//
//  TextFieldHolderViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 29/12/2021.
//

import Foundation
import UIKit

class TextFieldHolderViewController : UIViewController{}

extension TextFieldHolderViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
