//
//  ViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 23.01.2023.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var welcomeImageView: UIImageView!
    private var group = ""
    private var groupManager = GroupManager()
    private let scheduleManager = ScheduleManager()
    let window = UIWindow()
    
 
    @IBOutlet weak var moonImage: UIImageView!
    @IBOutlet weak var sunImage: UIImageView!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var seacrhTextField: UITextField!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Actions
    
    @IBAction func seacrhButton(_ sender: UIButton) {
        if seacrhTextField.text == "" {
            alert()
        } else {
            seacrhTextField.endEditing(true)
            self.performSegue(withIdentifier: Identifiers.GO_TO_LOADING_SEGUE, sender: self)
        }
    }
    
    @IBAction func switchMode(_ sender: UISwitch) {
        Tracker.mode = sender.isOn
        backgroundView.backgroundColor = Tracker.mode ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        if Tracker.mode {
            moonImage.image = UIImage(systemName: "moon.fill")
            moonImage.tintColor = .white
            sunImage.image = nil
            changeTextColor(mode: Tracker.mode)
        } else {
            sunImage.image = UIImage(systemName: "sun.max.fill")
            moonImage.image = nil
            changeTextColor(mode: Tracker.mode)
        }
    }
    
    //MARK: - Alert
    private func alert() {
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
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLoading" {
            let loadingVC = segue.destination as! LoadingViewController
            loadingVC.group = group
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        seacrhTextField?.delegate = self
        backgroundView.backgroundColor = Tracker.mode ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        switcher.isOn = Tracker.mode
        changeTextColor(mode: Tracker.mode)
    }
    
    
    func changeTextColor(mode: Bool) {
//        if mode {
//            Please.textColor = .white
//            letMe.textColor = .white
//            know.textColor = .white
//            your.textColor = .white
//        } else {
//            Please.textColor = .black
//            letMe.textColor = .black
//            know.textColor = .black
//            your.textColor = .black
//        }
        if mode {
            welcomeImageView.image = UIImage(named: "welcome_dark")
        } else {
            welcomeImageView.image = UIImage(named: "welcome_light")
        }
    }
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // the user pressed the return key
        if seacrhTextField.text == "" {
            alert()
        } else {
            seacrhTextField.endEditing(true)
            self.performSegue(withIdentifier: Identifiers.GO_TO_LOADING_SEGUE, sender: self)
        }
        textField.endEditing(true) 
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





