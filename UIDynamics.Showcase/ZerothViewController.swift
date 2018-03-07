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
    let twoFingerTapGesture :UITapGestureRecognizer
    
    var animatedView :UIView!
    var startFrame :CGRect!
    var animationYOffset :CGFloat!
    
    required init?(coder aDecoder: NSCoder) {
        tapGesture = UITapGestureRecognizer()
        twoFingerTapGesture = UITapGestureRecognizer()
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sideLength :CGFloat = 100
        animationYOffset = 200
        let endPositionY  = view.bounds.size.height - (sideLength + tabBarController!.tabBar.bounds.size.height )
        let startPositionY :CGFloat = endPositionY - animationYOffset
        let positionFromLeftSize :CGFloat = (view.bounds.size.width / 2) - (sideLength / 2)
        
        startFrame = CGRect(x: positionFromLeftSize, y: startPositionY, width: sideLength, height: sideLength)
        animatedView = UIView(frame: startFrame)
        animatedView.backgroundColor = .red
        
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.addTarget(self, action: #selector(didTap))
        twoFingerTapGesture.numberOfTouchesRequired = 2
        twoFingerTapGesture.addTarget(self, action: #selector(didTap))
        
        [tapGesture, twoFingerTapGesture].forEach { view.addGestureRecognizer($0) }
        
        view.addSubview(animatedView)
        
    }

    
    private func doAnimation() {
        
        let finalFrame = startFrame.offsetBy(dx: 0, dy: animationYOffset)
        let targetView = animatedView!
        let offset = animationYOffset!
        
        let attempt = 1
        
        switch attempt {
        case 1:
            // First attempt:
            UIView.animate(withDuration: 0.3) {
                targetView.frame = finalFrame
            }
        case 2:
            // Second attempt:
            UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                targetView.frame = finalFrame
            }, completion: nil)
            
        case 3:
            // Third attempt:
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                targetView.frame = finalFrame
            }) { (finished) in
                
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    targetView.frame = finalFrame.offsetBy(dx: 0, dy: -offset / 3)
                }, completion: { (finished) in
                    
                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                        targetView.frame = finalFrame
                    }, completion: nil)
                })
            }
        default: break
        }
    }
    
    private func resetScene() {
        animatedView.frame = startFrame
    }
    
    @objc func didTap(_ sender:UITapGestureRecognizer) {
        if sender == tapGesture {
            doAnimation()
        }
        else if sender == twoFingerTapGesture {
            resetScene()
        }
    }
    
}
