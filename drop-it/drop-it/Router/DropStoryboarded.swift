//
//  DropProtol.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

protocol DropStoryboarded{}

extension DropStoryboarded{
    
   private static var name : String{
        return "Drop"
    }
    
    static func instantiante<T : UIViewController>()->T{
        let className = String(describing: self)
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: className) as! T
    }
    
}
