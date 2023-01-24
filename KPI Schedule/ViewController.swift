//
//  ViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 23.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        switcher.isOn = false
    }


    @IBAction func switchMode(_ sender: UISwitch) {
        if switcher.isOn {
            backgroundView.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1)
        }
        else {
            backgroundView.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        }
    }
}

