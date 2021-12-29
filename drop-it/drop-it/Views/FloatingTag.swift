//
//  FloatingTag.swift
//  drop-it
//
//  Created by Ruben Mimoun on 28/12/2021.
//

import Foundation
import UIKit

protocol FloatingTagDelegate : AnyObject {
    func inBasket(bagname : String)
}

class FloatingTag : UIView , UIGestureRecognizerDelegate{

    var removeFrame : CGRect?
    var originPoint : CGPoint!
    var lastLocation = CGPoint(x: 0, y: 0)
    var bagName : String!
    weak var delegate : FloatingTagDelegate!
    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var bagLabel: UILabel!
    
    private func commonInit(){
        Bundle.main.loadNibNamed("FloatingTag", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentView.setRoundCorners(cornerRadius: self.frame.height / 2)
        contentView.shadeView()
        initGestures()
    }
    
    private func initGestures(){
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(detectPan))
        panRecognizer.delegate = self
        self.gestureRecognizers = [panRecognizer]
    }
    
    private func handlePanGesture(_ recognizer : UIGestureRecognizer){
        if(recognizer.state == .ended)
         {
            if self.frame.intersects(removeFrame!){
                recognizer.isEnabled = false
                scaleWithAnimation(value: 0.1) { finished in
                    if finished{
                        self.delegate.inBasket(bagname: self.bagName)
                            self.removeFromSuperview()
                    }
                }
            }else{
                self.center = CGPoint(x: self.originPoint.x + frame.width / 2, y: self.originPoint.y + frame.height / 2)
            }
        }
    }
    
    @objc func detectPan(_ recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.translation(in: self.superview)
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
        handlePanGesture(recognizer)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubviewToFront(self)
        lastLocation = self.center
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    init(delegate : FloatingTagDelegate, frame: CGRect, bagName : String, removeFrame : CGRect) {
        super.init(frame: frame)
        commonInit()
        self.bagName = bagName
        self.bagLabel.text = bagName
        self.removeFrame = removeFrame
        self.originPoint = frame.origin
        self.delegate = delegate
    }
}
