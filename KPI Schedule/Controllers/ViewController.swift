//
//  ViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 23.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    private var group = ""
    private var groupManager = GroupManager()
    private let scheduleManager = ScheduleManager()
    
    @IBOutlet weak var moonImage: UIImageView!
    @IBOutlet weak var sunImage: UIImageView!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var seacrhTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seacrhTextField?.delegate = self
    }
    
    @IBAction func seacrhButton(_ sender: UIButton) {
        if seacrhTextField.text == "" {
            self.alert()
        } else {
            seacrhTextField.endEditing(true)
            self.performSegue(withIdentifier: "goToLoading", sender: self)
        }
    }
    
    @IBAction func switchMode(_ sender: UISwitch) {
        backgroundView.backgroundColor = switcher.isOn ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        if switcher.isOn {
            moonImage.image = UIImage(systemName: "moon.fill")
            sunImage.image = nil
        } else {
            sunImage.image = UIImage(systemName: "sun.min.fill")
            moonImage.image = nil
        }
    }
    func alert() {
        let alert = UIAlertController(title: "Oops!", message: "It seems like you have not typed the group!", preferredStyle: .alert)
             let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
             })
             alert.addAction(ok)
             let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
             })
             alert.addAction(cancel)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLoading" {
            let loadingVC = segue.destination as! LoadingViewController
            loadingVC.group = group
        }
    }
}

//MARK: - UITextField

extension ViewController: UITextFieldDelegate {
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
}





