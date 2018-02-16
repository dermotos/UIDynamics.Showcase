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
    let gravitationalConstant = 9.8
    let gravity = UIGravityBehavior()
    

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
        gravity.gravityDirection = CGVector(dx: 0, dy: gravitationalConstant)
        
        animator.addBehavior(gravity)
        
        let frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        let aBox = UIView(frame: frame)
        aBox.center = view.center
        aBox.backgroundColor = .red
        view.addSubview(aBox)
    }

    @IBAction func didTapStart(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapReset(_ sender: UIButton) {
        
    }
    
}

