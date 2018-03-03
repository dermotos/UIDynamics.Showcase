//
//  BounceSwitch.swift
//  UIDynamics.Showcase
//
//  Created by Dermot O Sullivan on 3/3/18.
//  Copyright © 2018 Rocky Desk. All rights reserved.
//

import Foundation
import UIKit

protocol BounceSwitchDelegate : AnyObject {
    
    func valueDidChange(of sender:BounceSwitch, to newValue:Bool)
}

class BounceSwitch : UIView {
    
    let tapRecognizer: UITapGestureRecognizer!
    let backgroundView :UIView!
    let sliderView :UIView!
    
    public weak var delegate :BounceSwitchDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        tapRecognizer = UITapGestureRecognizer()
        backgroundView = UIView()
        sliderView = UIView()
        
        
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        tapRecognizer.addTarget(self, action: #selector(didTap))
        addGestureRecognizer(tapRecognizer)
        backgroundColor = .clear
        backgroundView.frame = bounds
        backgroundView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        addSubview(backgroundView)
 
        
    }
    
    @objc func didTap(_ sender:UITapGestureRecognizer) {
        print("I was tapped")
    }
    
    
    
}
