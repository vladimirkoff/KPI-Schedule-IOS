//
//  LoadingViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 31.01.2023.
//

import UIKit

class LoadingViewController: UIViewController, ScheduleManagerDelegate, GroupManagerDelegate {
    
    @IBOutlet weak var pleaseWait: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    var group = "nil"
    var schedule: [Int : [[PairModel]]]?
    var groupManager = GroupManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pleaseWait.textColor = Tracker.mode ? .white : .black
        backgroundView.backgroundColor = Tracker.mode ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        groupManager.delegate = self
        groupManager.del = self
        groupManager.performRequestForGroup(group: group)
        pleaseWait.textColor = Tracker.mode ? .white : .black
    }
    
    func didFailWithGroup() {
        self.performSegue(withIdentifier: Strings.segue2Identifier, sender: self)
    }
    
    func didUpdate(schedule: [Int : [[PairModel]]]) {
        self.schedule = schedule
        self.performSegue(withIdentifier: Urls.segueIdentifier, sender: self)
    }
    
    func didFail(error: Error) {
        self.performSegue(withIdentifier: Strings.segue2Identifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Strings.segueIdentifier {
            let scheduleVC = segue.destination as! ScheduleViewController
            scheduleVC.schedule = self.schedule
        }
    }
}
