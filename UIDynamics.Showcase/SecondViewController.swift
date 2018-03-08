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
    private var itemBehavior: UIDynamicItemBehavior!
    
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
            removeItemBehaviors()

            let centerOffset = UIOffset(horizontal: squareLocation.x - redSquare.bounds.midX,
                                        vertical: squareLocation.y - redSquare.bounds.midY)
            attachmentBehavior = UIAttachmentBehavior(item: redSquare,
                                                      offsetFromCenter: centerOffset, attachedToAnchor: location)

            animator.addBehavior(attachmentBehavior)
            
            itemBehavior = UIDynamicItemBehavior(items: [redSquare])
            itemBehavior.allowsRotation = false
            animator.addBehavior(itemBehavior)
            
        case .ended:
            
            removeDragBehaviors()
            
        default:
            attachmentBehavior!.anchorPoint = sender.location(in: view)
        }
    }
    
    private func removeItemBehaviors() {
        if itemBehavior != nil && animator.behaviors.contains(itemBehavior) {
            animator.removeBehavior(itemBehavior)
        }
    }
    
    private func removeDragBehaviors() {
        if attachmentBehavior != nil && animator.behaviors.contains(attachmentBehavior) {
            animator.removeBehavior(attachmentBehavior)
        }
    }
    
}

