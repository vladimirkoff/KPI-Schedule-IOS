//
//  ViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 23.01.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ScheduleManagerDelegate {
    func didFail(error: Error) {
        print(error)
    }
    
    
    
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var third: UILabel!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var seacrhTextField: UITextField!
    
    var groupManager = GroupManager()
    var scheduleManager = ScheduleManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seacrhTextField.delegate = self
        scheduleManager.delegate = self
    }
    
    @IBAction func seacrhButton(_ sender: UIButton) {
        seacrhTextField.endEditing(true)
    }
    
    @IBAction func switchMode(_ sender: UISwitch) {
        backgroundView.backgroundColor = switcher.isOn ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)                      // the user pressed the return key!
        print(textField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type in you group"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use the info
        groupManager.performRequest(group: textField.text!)
        textField.text = ""
    }
    func didUpdate(schedule: ScheduleModel) {
        DispatchQueue.main.async {
            print(schedule.name)
            print(schedule.type)
            print(schedule.teacherName)
            print(schedule.time)
            print(schedule.day)
        }
    }
}





