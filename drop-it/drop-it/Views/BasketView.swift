//
//  BasketView.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

class BasketView : UIView{
    
    var bagCount : Int = 0 {
        didSet{
            bagLabel.text = "\(bagCount)"
        }
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var bagLabel: UILabel!
    
    private func commonInit(){
        Bundle.main.loadNibNamed("BasketView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        bagLabel.setRoundCorners(cornerRadius: 20)
        bagLabel.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()

    }
    
}
