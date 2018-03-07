//
//  ZerothViewController.swift
//  UIDynamics.Showcase
//
//  Created by Dermot on 7/3/18.
//  Copyright © 2018 Rocky Desk. All rights reserved.
//

import Foundation
import UIKit


class ZerothViewController : UIViewController {
    
    let tapGesture :UITapGestureRecognizer
    let doubleTapGesture :UITapGestureRecognizer
    
    var animatedView :UIView!
    var startFrame :CGRect!
    var animationYOffset :CGFloat!
    
    required init?(coder aDecoder: NSCoder) {
        tapGesture = UITapGestureRecognizer()
        doubleTapGesture = UITapGestureRecognizer()
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sideLength :CGFloat = 100
        animationYOffset = 200
        let endPositionY  = view.bounds.size.height - sideLength
        let startPositionY :CGFloat = endPositionY - animationYOffset
        let positionFromLeftSize :CGFloat = (view.bounds.size.width / 2) - (sideLength / 2)
        
        startFrame = CGRect(x: positionFromLeftSize, y: startPositionY, width: sideLength, height: sideLength)
        animatedView = UIView(frame: startFrame)
        animatedView.backgroundColor = .red
        
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: #selector(didTap))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.addTarget(self, action: #selector(didTap))
        
        [doubleTapGesture, tapGesture].forEach { view.addGestureRecognizer($0) }
        
        view.addSubview(animatedView)
        
    }

    
    private func doAnimation() {
        
        let finalFrame = startFrame.offsetBy(dx: 0, dy: animationYOffset)
        let targetView = animatedView!
        let offset = animationYOffset!
        
        // First attempt:
        UIView.animate(withDuration: 0.3) {
            targetView.frame = finalFrame
        }
    
        // Second attempt:
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
//            targetView.frame = finalFrame
//        }, completion: nil)
        
        // Third attempt:
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
//            targetView.frame = finalFrame
//        }) { (finished) in
//
//            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
//                targetView.frame = finalFrame.offsetBy(dx: 0, dy: -offset / 3)
//            }, completion: { (finished) in
//
//                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
//                    targetView.frame = finalFrame
//                }, completion: nil)
//            })
//        }
        
    }
    
    private func resetScene() {
        animatedView.frame = startFrame
    }
    
    @objc func didTap(_ sender:UITapGestureRecognizer) {
        if sender == tapGesture {
            doAnimation()
        }
        else if sender == doubleTapGesture {
            resetScene()
        }
    }
    
}
