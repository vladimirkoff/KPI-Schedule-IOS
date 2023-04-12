//
//  ViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 23.01.2023.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var moonImage: UIImageView!
    @IBOutlet weak var sunImage: UIImageView!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var seacrhTextField: UITextField!
    @IBOutlet weak var welcomeImageView: UIImageView!
    
    private var group = ""
    
   private let attributedPlaceholder = NSAttributedString(
        string: "Type in your group",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.7)]
    )
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seacrhTextField?.delegate = self
        configureUI()
    }
    
    //MARK: - Actions
    
    @IBAction func seacrhButton(_ sender: UIButton) {
        guard !seacrhTextField.text!.isEmpty else {
            alert()
            return
        }
        seacrhTextField.endEditing(true)
        performSegue(withIdentifier: Identifiers.GO_TO_LOADING_SEGUE, sender: self)
    }
    
    @IBAction func switchMode(_ sender: UISwitch) {
        Tracker.mode = sender.isOn
        configureUI()
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
        
        present(alert, animated: true)
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.GO_TO_LOADING_SEGUE {
            let loadingVC = segue.destination as! LoadingViewController
            loadingVC.group = group
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        seacrhTextField.attributedPlaceholder = attributedPlaceholder
        backgroundView.backgroundColor = Tracker.mode ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        switcher.isOn = Tracker.mode
        changeTextColor(mode: Tracker.mode)
    }
    
    func changeAppearance(mode: Bool) {
        if mode {
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
    
    
    func changeTextColor(mode: Bool) {
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
            performSegue(withIdentifier: Identifiers.GO_TO_LOADING_SEGUE, sender: self)
        }
        textField.endEditing(true) 
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        group = textField.text!
        textField.text = ""
    }
}





