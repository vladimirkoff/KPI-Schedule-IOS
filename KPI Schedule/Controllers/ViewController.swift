//
//  ViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 23.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var test = GroupManager()
    
    
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var seacrhTextField: UITextField!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func switchMode(_ sender: UISwitch) {
        backgroundView.backgroundColor = switcher.isOn ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if let group = seacrhTextField.text {
            test.performRequest(for: group)
        }
        self.performSegue(withIdentifier: "goToSchedule", sender: self)
    }
    
}
