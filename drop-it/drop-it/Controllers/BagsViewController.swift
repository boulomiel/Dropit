//
//  BagsViewController.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

class BagsViewController : UIViewController, DropStoryboarded{
    
    var basketView : BasketView!
    var dropViewModel : DropViewModel!
    @IBOutlet weak var reviewButtonOutlet: UIButton!{
        didSet{
            reviewButtonOutlet.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        setupBasketView()
        configureBags()
        setupBagsListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupBagsListener(){
        dropViewModel.startBagsUpdate { bags in
            DispatchQueue.main.async {[weak self] in
                if !bags.isEmpty{
                    self?.reviewButtonOutlet.scaleWithAnimation(value: 1, completion: nil)
                    self?.basketView.bagCount = bags.count
                }
            }
        }
    }
    
    private func setupBasketView(){
        let point = CGPoint(x: self.view.center.x - 45 , y: self.view.frame.maxY - 160)
        basketView = BasketView(frame: CGRect(origin: point, size: CGSize(width: 90, height: 120)))
        self.view.addSubview(basketView!)
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {[weak self] in
            self?.basketView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    private func configureBags(){
        let userCurrentBags = dropViewModel.getCurrentBags()
        let length = 50.0
        let top = 140.0
        for i in 1...userCurrentBags.count{
            self.view.addSubview(FloatingTag(delegate: self, frame: CGRect(x: Double(i) * length, y: top, width: 120, height: length), bagName: userCurrentBags[i - 1], removeFrame: basketView.frame))
        }
    }
    
    private func configureNavbar(){
        setupTitle(Constants.pickYourBags)
        setupBackButton()
    }
    
    @IBAction func reviewButtonAction(_ sender: Any) {
        Router.showReviewViewController(dropViewModel)
    }
}

extension BagsViewController : FloatingTagDelegate{
    func inBasket(bagname : String) {
        dropViewModel.addBag(bagId: bagname)
    }
}
