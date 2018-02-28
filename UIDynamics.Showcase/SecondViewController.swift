//
//  SecondViewController.swift
//  UIDynamics.Showcase
//
//  Created by Dermot on 16/2/18.
//  Copyright © 2018 Rocky Desk. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    private var animator :UIDynamicAnimator!
    
    private var collisionBehavior:UICollisionBehavior!
    
    private var attachmentBehavior: UIAttachmentBehavior!
    private var pushBehavior: UIPushBehavior!
    private var itemBehavior: UIDynamicItemBehavior!
    
    private var radialGravity :UIFieldBehavior!
    
    private var panRecognizer :UIPanGestureRecognizer!
    
    private var redSquare:  UIView!
    
    private var originalBounds = CGRect.zero
    private var originalCenter = CGPoint.zero
    
    private let limitingFriction :CGFloat = 1000
    private let velocityPadding :CGFloat = 35
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleDragGesture(sender:)))
        view.addGestureRecognizer(panRecognizer)
        
        // Red Square
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        redSquare = UIView(frame: frame)
        redSquare.backgroundColor = .red
        view.addSubview(redSquare)
        redSquare.center = view.center
        
        animator = UIDynamicAnimator(referenceView: view)
        
        let anchor = UIDynamicItemBehavior(items: [view])
        anchor.isAnchored = true
        animator.addBehavior(anchor)
        
        radialGravity = UIFieldBehavior.radialGravityField(position: view.center)
        radialGravity.addItem(redSquare)
        
    
        
        originalBounds = redSquare.bounds
        originalCenter = redSquare.center
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collisionBehavior = UICollisionBehavior(items: [redSquare])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc private func handleDragGesture(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let squareLocation = sender.location(in: redSquare)
        
        switch sender.state {
        case .began:
            
            removeDragBehaviors()
            removeVelocityBehaviors()

            let centerOffset = UIOffset(horizontal: squareLocation.x - redSquare.bounds.midX,
                                        vertical: squareLocation.y - redSquare.bounds.midY)
            attachmentBehavior = UIAttachmentBehavior(item: redSquare,
                                                      offsetFromCenter: centerOffset, attachedToAnchor: location)
            
            animator.addBehavior(attachmentBehavior)
            
        case .ended:
            
            removeDragBehaviors()
            
//            let velocity = sender.velocity(in: view)
//            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
//            impartVelocity(velocity, withMagnitude: magnitude, onView: redSquare)
            
        default:
            attachmentBehavior!.anchorPoint = sender.location(in: view)
        }
    }
    
    private func removeVelocityBehaviors() {
        if pushBehavior != nil && animator.behaviors.contains(pushBehavior) {
            animator.removeBehavior(pushBehavior)
        }
        
        if itemBehavior != nil && animator.behaviors.contains(itemBehavior) {
            animator.removeBehavior(itemBehavior)
        }
    }
    
    private func removeDragBehaviors() {
        if attachmentBehavior != nil && animator.behaviors.contains(attachmentBehavior) {
            animator.removeBehavior(attachmentBehavior)
        }
    }
    
//    private func impartVelocity(_ velocity:CGPoint, withMagnitude magnitude:CGFloat, onView item:UIDynamicItem) {
//        if magnitude > limitingFriction {
//            let pushBehaviour = UIPushBehavior(items: [item], mode: .instantaneous)
//            pushBehaviour.pushDirection = CGVector(dx: velocity.x / 10, dy: velocity.y / 10)
//            pushBehaviour.magnitude = 100 /// velocityPadding
//            self.pushBehavior = pushBehaviour
//
//            animator.addBehavior(pushBehaviour)
//
//            let angle = Int(arc4random_uniform(20)) - 10
//            itemBehavior = UIDynamicItemBehavior(items: [item])
//            itemBehavior!.friction = 0.2
//            itemBehavior!.allowsRotation = true
//            itemBehavior!.addAngularVelocity(CGFloat(angle), for: item)
//            //animator.addBehavior(itemBehavior!)
//        }
//    }
}

