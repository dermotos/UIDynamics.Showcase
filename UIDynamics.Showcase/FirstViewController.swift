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
        
        animator.addBehavior(collision)
        animator.addBehavior(gravity)
        animator.addBehavior(elasticity)
    }
    
    private func addBox(atPosition position:CGPoint, withColor color:UIColor) -> UIView {
        let boxSize = CGSize(width: 150, height: 150)
        let frame = CGRect(origin: position, size: boxSize)
        let aBox = UIView(frame: frame)
        aBox.backgroundColor = color
        view.addSubview(aBox)
        return aBox
    }
    
    private func addBasePhysics(to view:UIView) {
        gravity.addItem(view)
        collision.addItem(view)
    }
    
    private func addElasticity(to view:UIView) {
        elasticity.addItem(view)
    }
    
    
    
    private func resetScene() {
        
        
    }

    @IBAction func didTapStart(_ sender: UIButton) {
        let boxOnePosition = CGPoint(x: 10, y: 10)
        let boxOne = addBox(atPosition: boxOnePosition, withColor: .red)
        addBasePhysics(to: boxOne)
        addElasticity(to: boxOne)
        //TODO: Add first box, then second box along with a barrier, then gravity, then push them towards each other.
        //Second view controller is orbit
        //Third is real world example, perhaps a table view with a UIDynamics transition animator
        //fourth if I've time is a name picker
    }
    
    @IBAction func didTapReset(_ sender: UIButton) {
        
    }
    
}

