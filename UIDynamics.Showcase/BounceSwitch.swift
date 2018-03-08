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

protocol BounceSwitchInterface : AnyObject {
    /// Set the switch position
    var isOn : Bool { get set }
    /// Toggle the switch from on to off, or vice versa
    func toggle()
}

class BounceSwitch : UIView, BounceSwitchInterface {
    
    private let defaultGravity = 1.9
    private let defaultElasticity :CGFloat = 0.6

    
    let tapRecognizer: UITapGestureRecognizer!
    let backgroundView :UIView!
    let sliderView :UIView!
    
    private var animator :UIDynamicAnimator!
    private var horizontalGravity :UIGravityBehavior!
    private var collisions :UICollisionBehavior!
    private var elasticity : UIDynamicItemBehavior!
    
    public weak var delegate :BounceSwitchDelegate?
    
    // If gravity is above zero, the switch is on. If it below zero, it is off
    var currentGravity :Double {
        didSet {
            horizontalGravity.gravityDirection = CGVector(dx: currentGravity, dy: 0)
        }
    }
    
    internal var isOn : Bool {
        get {
            return currentGravity >= 0
        }
        set {
            currentGravity = newValue ? defaultGravity : -defaultGravity
        }
    }
    
    internal func toggle() {
        isOn = !isOn
    }
    
    private func updateGravity(toMagnitude magnitude:Double) {
        horizontalGravity.gravityDirection = CGVector(dx: magnitude, dy: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        tapRecognizer = UITapGestureRecognizer()
        backgroundView = UIView()
        sliderView = UIView()
        currentGravity = -defaultGravity
        
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        tapRecognizer.addTarget(self, action: #selector(didTap))
        addGestureRecognizer(tapRecognizer)
        backgroundColor = .clear
        backgroundView.frame = bounds
        backgroundView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        backgroundView.layer.cornerRadius = bounds.size.height / 2
        backgroundView.layer.borderWidth = 1.0
        backgroundView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        addSubview(backgroundView)
        
        sliderView.frame = CGRect(x: 0, y: 0, width: bounds.size.height, height: bounds.size.height)
        sliderView.backgroundColor = #colorLiteral(red: 0.5255542397, green: 0.9854720235, blue: 0.01467773691, alpha: 1)
        sliderView.layer.borderWidth = 0.5
        sliderView.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1).cgColor
        sliderView.layer.cornerRadius = bounds.size.height / 2
        backgroundView.addSubview(sliderView)
        
        /* Dynamics */
        animator = UIDynamicAnimator(referenceView: backgroundView)
        
        // Setup collisions
        collisions = UICollisionBehavior(items: [sliderView])
        collisions.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisions)
        
        // Setup gravity
        horizontalGravity = UIGravityBehavior(items: [sliderView])
        horizontalGravity.gravityDirection = CGVector(dx: currentGravity, dy: 0)
        animator.addBehavior(horizontalGravity)
        
        // Bounciness of toggle
        elasticity = UIDynamicItemBehavior(items: [sliderView])
        elasticity.elasticity = defaultElasticity
        animator.addBehavior(elasticity)
 
        
    }
    
    @objc func didTap(_ sender:UITapGestureRecognizer) {
        toggle()
        delegate?.valueDidChange(of: self, to: isOn)
    }
    
    
    
}
