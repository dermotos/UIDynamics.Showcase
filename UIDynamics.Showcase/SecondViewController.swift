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
    private var attachmentBehavior: UIAttachmentBehavior!
    private var pushBehavior: UIPushBehavior!
    private var itemBehavior: UIDynamicItemBehavior!
    
    private var panRecognizer :UIPanGestureRecognizer!
    
    private var redSquare:  UIView!
    
    private var touchPoint: UIView!
    private var dragPoint:  UIView!
    
    private var originalBounds = CGRect.zero
    private var originalCenter = CGPoint.zero
    
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
        originalBounds = redSquare.bounds
        originalCenter = redSquare.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc private func handleDragGesture(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let boxLocation = sender.location(in: redSquare)
        
        switch sender.state {
        case .began:
            print("Your touch start position is \(location)")
            print("Start location in image is \(boxLocation)")
            
            // 1
            animator.removeAllBehaviors()
            
            // 2
            let centerOffset = UIOffset(horizontal: boxLocation.x - imageView.bounds.midX,
                                        vertical: boxLocation.y - imageView.bounds.midY)
            attachmentBehavior = UIAttachmentBehavior(item: redSquare,
                                                      offsetFromCenter: centerOffset, attachedToAnchor: location)
            
            // 3
            redSquare.center = attachmentBehavior.anchorPoint
            blueSquare.center = location
            
            // 4
            animator.addBehavior(attachmentBehavior)
            
        case .ended:
            print("Your touch end position is \(location)")
            print("End location in image is \(boxLocation)")
            
        default:
            break
        }
    }
}

