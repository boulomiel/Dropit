//
//  Router.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

struct Router{
    
    private static var root : UIWindow? = {
        guard let firstScene = UIApplication.shared.connectedScenes.first,
              let delegate =  firstScene.delegate as? SceneDelegate,
              let root = delegate.window else {
                  return nil
              }
        return root
    }()
    
    private static var navigationController : UINavigationController? = {
        guard let navController = root?.rootViewController as? UINavigationController else {
                  print("Router", "No navigation controller at the root")
                  return nil}
        return navController
    }()
    
    private static func push<T : UIViewController>(controller : T){
        
        let controllers = navigationController?.viewControllers ?? []
        if !controllers.contains(controller){
            navigationController?.pushViewController(controller, animated:  true)
        }else{
            if let index =  controllers.firstIndex(where: {String(describing: $0) == String(describing: controllers)}){
                navigationController?.popToViewController(controllers[index], animated: true)
            }
        }
    }
    
    static func showContactDetailsViewController(){
        let vc =  ContactDetailsViewController.instantiante()
        push(controller: vc)
    }
    
    static func showAdressViewController(){
        let vc =  AddressViewController.instantiante()
        push(controller: vc)
    }
    
    static func showDropBagsViewController(){
        let vc = BagsViewController.instantiante()
        push(controller: vc)
    }
    
    static func showReviewViewController(){
        let vc = ReviewViewController.instantiante()
        push(controller: vc)
    }
    
    static func showResultViewController(){
        let vc = ResultViewController.instantiante()
        push(controller: vc)
    }
    
    
}
