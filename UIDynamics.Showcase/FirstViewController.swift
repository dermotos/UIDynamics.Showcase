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
    
    @IBOutlet weak var controlContainer: UIVisualEffectView!
    
    var gravity: UIGravityBehavior?
    var collision :UICollisionBehavior?
    var boxProperties :UIDynamicItemBehavior?


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func clearEnvironment() {
        if let animator = animator {
            animator.removeAllBehaviors()
        }
        
        view.subviews
            .filter  {  $0 != controlContainer   }
            .forEach {  $0.removeFromSuperview() }
    }
    
    private func addFloor() {
        let floorSize = CGSize(width: view.bounds.size.width, height: 10)
        let floorPosition = CGPoint(x: 0, y: view.bounds.size.height - 100)
        let theFloor = addView(atPosition: floorPosition, withSize: floorSize, andColor: .blue)
        
        collision?.addItem(theFloor)
        
        let floorAttachment =
            UIAttachmentBehavior.pinAttachment(with: theFloor,
                                               attachedTo: view,
                                               attachmentAnchor: theFloor.center)
        animator.addBehavior(floorAttachment)
    }
    
    private func setupEnvironment() {
        animator = UIDynamicAnimator(referenceView: view)
        let anchor = UIDynamicItemBehavior(items: [view])
        anchor.isAnchored = true
        animator.addBehavior(anchor)
 
        // 1 - Gravity
        gravity = UIGravityBehavior()
        gravity!.gravityDirection = CGVector(dx: 0, dy: gravitationalConstant)
        animator.addBehavior(gravity!)
        
        // 2 - Collisions
//        collision = UICollisionBehavior()
//        collision!.translatesReferenceBoundsIntoBoundary = true
//        animator.addBehavior(collision!)
        
        // 3. Box properties
//        boxProperties = UIDynamicItemBehavior()
//        boxProperties!.elasticity = 0.5
//        boxProperties!.angularResistance = 2.0
//        animator.addBehavior(boxProperties!)
    }
    
    private func addView(atPosition position:CGPoint, withSize size:CGSize, andColor color:UIColor) -> UIView {
        let frame = CGRect(origin: position, size: size)
        let aBox = UIView(frame: frame)
        aBox.backgroundColor = color
        view.addSubview(aBox)
        return aBox
    }
    
  
    
    @IBAction func didTapAddBox(_ sender: UIButton) {
        if animator == nil {
            setupEnvironment()
        }
        let boxSize = CGSize(width: 50, height: 50)
        let boxPosition = CGPoint(x: view.bounds.size.width / 2 - boxSize.width / 2, y: 10)
        
        let theBox = addView(atPosition: boxPosition, withSize: boxSize, andColor: .red)
        gravity?.addItem(theBox)
        collision?.addItem(theBox)
        boxProperties?.addItem(theBox)
    }
    
    @IBAction func didTapReset(_ sender: UIButton) {
        clearEnvironment()
        setupEnvironment()
        addFloor()
    }
    
}

