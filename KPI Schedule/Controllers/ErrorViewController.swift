//
//  ErrorViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 31.01.2023.
//

import UIKit

class ErrorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goBackToInit", sender: self)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
