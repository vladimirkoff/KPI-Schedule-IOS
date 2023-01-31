//
//  ErrorViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 31.01.2023.
//

import UIKit

class ErrorViewController: UIViewController {
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.backgroundColor = Tracker.mode ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Strings.segue3Identifier, sender: self)
    }
}
