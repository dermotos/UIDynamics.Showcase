//
//  FourthViewController.swift
//  UIDynamics.Showcase
//
//  Created by Dermot O Sullivan on 3/3/18.
//  Copyright © 2018 Rocky Desk. All rights reserved.
//

import Foundation
import UIKit

class FourthViewController : UITableViewController, BounceSwitchDelegate {
    
    
    
    private let ordinalFormatter :NumberFormatter
    
    required init?(coder aDecoder: NSCoder) {
        ordinalFormatter = NumberFormatter()
        super.init(coder: aDecoder)
        ordinalFormatter.numberStyle = .ordinal
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    func valueDidChange(of sender: BounceSwitch, to newValue: Bool) {
        print("A bounce switch change was reported to the view controller")
    }
    
    
    // MARK: - UITableViewDelegate & DataSource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let ordinal = ordinalFormatter.string(from: NSNumber(integerLiteral: indexPath.row))!
        cell.textLabel?.text = "\(ordinal) row"
        
        let switchFrame = CGRect(x: 0, y: 0, width: 80, height: 30)
        let toggleSwitch = BounceSwitch(frame: switchFrame)
        toggleSwitch.tag = indexPath.row
        toggleSwitch.delegate = self
        cell.accessoryView = toggleSwitch
        
        return cell
    }
    
}
