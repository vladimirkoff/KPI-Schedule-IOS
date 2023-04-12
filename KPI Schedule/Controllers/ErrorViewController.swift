//
//  ErrorViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 31.01.2023.
//

import UIKit

class ErrorViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var describingError: UILabel!
    @IBOutlet weak var oopsLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        oopsLabel.textColor = Tracker.mode ? .white : .black
        describingError.textColor = Tracker.mode ? .white : .black
        backgroundView.backgroundColor = Tracker.mode ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
    }
    
    //MARK: - Actions
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Identifiers.GO_BACK_SEGUE, sender: self)
    }
}
