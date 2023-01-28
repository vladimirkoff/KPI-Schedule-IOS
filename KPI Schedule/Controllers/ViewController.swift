//
//  ViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 23.01.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    func didFail(error: Error) {
        print("Oshybka")
    }
    
    @IBOutlet weak var moonImage: UIImageView!
    @IBOutlet weak var sunImage: UIImageView!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var seacrhTextField: UITextField!
    
    var groupManager = GroupManager()
    var scheduleManager = ScheduleManager()
    
    private var group = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seacrhTextField.delegate = self
    }
    
    @IBAction func seacrhButton(_ sender: UIButton) {
        seacrhTextField.endEditing(true)
        self.performSegue(withIdentifier: UrlsAndStrings.segueIdentifier, sender: self)
    }
    
    @IBAction func switchMode(_ sender: UISwitch) {
        backgroundView.backgroundColor = switcher.isOn ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        if switcher.isOn {
            moonImage.image = UIImage(named: "moon.fill")
        } else {
            sunImage.image = UIImage(named: "sun.min.fill")
        }
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
        self.group = textField.text!
        textField.text = ""
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scheduleVC = segue.destination as! ScheduleViewController
        scheduleVC.group = group
    }
}





