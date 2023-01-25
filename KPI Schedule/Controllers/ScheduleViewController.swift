//
//  ScheduleViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 25.01.2023.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    override func viewDidLoad() {
        
    }
    
    
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        if segmentBar.selectedSegmentIndex == 0 {
            
        }
        
    }
}
