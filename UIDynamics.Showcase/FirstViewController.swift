//
//  FirstViewController.swift
//  UIDynamics.Showcase
//
//  Created by Dermot on 16/2/18.
//  Copyright © 2018 Rocky Desk. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var animator :UIDynamicAnimator!
    
    let gravitationalConstant = 0.4
    let elasticConstant :CGFloat = 0.9
    
    
    var gravity: UIGravityBehavior!
    var collision :UICollisionBehavior!
    var elasticity :UIDynamicItemBehavior!
    
    var spring :UISnapBehavior!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupEnvironment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupEnvironment() {
        animator = UIDynamicAnimator(referenceView: view)
        
        collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        
        gravity = UIGravityBehavior()
        gravity.gravityDirection = CGVector(dx: 0, dy: gravitationalConstant)
        
        elasticity = UIDynamicItemBehavior()
        elasticity.elasticity = elasticConstant
        
        let anchor = UIDynamicItemBehavior(items: [view])
        anchor.isAnchored = true
        animator.addBehavior(anchor)
        
        
        
        animator.addBehavior(collision)
        animator.addBehavior(gravity)
        animator.addBehavior(elasticity)
    }
    
    private func addView(atPosition position:CGPoint, withSize size:CGSize, andColor color:UIColor) -> UIView {
        let frame = CGRect(origin: position, size: size)
        let aBox = UIView(frame: frame)
        aBox.backgroundColor = color
        view.addSubview(aBox)
        return aBox
    }
    
  

    @IBAction func didTapStart(_ sender: UIButton) {
        let boxSize = CGSize(width: 50, height: 50)
        let boxPosition = CGPoint(x: view.bounds.size.width / 2 - boxSize.width / 2, y: 10)
        
        let theBox = addView(atPosition: boxPosition, withSize: boxSize, andColor: .red)
        gravity.addItem(theBox)
        collision.addItem(theBox)
        
        elasticity.addItem(view)
        
        let floorSize = CGSize(width: view.bounds.size.width, height: 10)
        let floorPosition = CGPoint(x: 0, y: view.bounds.size.height - 80)
        let theFloor = addView(atPosition: floorPosition, withSize: floorSize, andColor: .blue)
        
        collision.addItem(theFloor)
        
        let attachment = UIAttachmentBehavior.pinAttachment(with: theFloor, attachedTo: view, attachmentAnchor: theFloor.center)
        // UIAttachmentBehavior(item: theFloor, attachedToAnchor: theFloor.frame.origin)
        animator.addBehavior(attachment)
        
        elasticity.addItem(theBox)
        
    }
    
    @IBAction func didTapReset(_ sender: UIButton) {
        
    }
    
}

