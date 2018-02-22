//
//  SecondViewController.swift
//  UIDynamics.Showcase
//
//  Created by Dermot on 16/2/18.
//  Copyright © 2018 Rocky Desk. All rights reserved.
//

import UIKit

class OrreryViewController: UIViewController {

    var animator :UIDynamicAnimator!
    
    var gravityWell :UIFieldBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupEnvironment() {
        animator = UIDynamicAnimator(referenceView: view)
        
        gravityWell = UIFieldBehavior()
        gravityWell.radi
        
//        collision = UICollisionBehavior()
//        collision.translatesReferenceBoundsIntoBoundary = true
//
//        gravity = UIGravityBehavior()
//        gravity.gravityDirection = CGVector(dx: 0, dy: gravitationalConstant)
//
//        elasticity = UIDynamicItemBehavior()
//        elasticity.elasticity = elasticConstant
//
//        let anchor = UIDynamicItemBehavior(items: [view])
//        anchor.isAnchored = true
//        animator.addBehavior(anchor)
//
//        animator.addBehavior(collision)
//        animator.addBehavior(gravity)
//        animator.addBehavior(elasticity)
    }
    
    private func addView(atPosition position:CGPoint, withSize size:CGSize, andColor color:UIColor) -> UIView {
        let frame = CGRect(origin: position, size: size)
        let aBox = UIView(frame: frame)
        aBox.backgroundColor = color
        view.addSubview(aBox)
        return aBox
    }
    
    


}

