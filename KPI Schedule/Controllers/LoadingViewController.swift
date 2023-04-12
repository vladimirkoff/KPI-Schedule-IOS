//
//  LoadingViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 31.01.2023.
//

import UIKit

class LoadingViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var pleaseWait: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    var group = ""
    
    private var schedule: [Int : [[PairModel]]]?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GroupManager.delegate = self
        configureUI()
        ScheduleManager.delegate = self
        getSchedule()
    }
    
    //MARK: - API
    
    func getSchedule() {
        GroupManager.performRequestForGroup(group: group) { group in
            ScheduleManager.performRequestForSchedule(id: group.id)
        }
    }
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.GO_TO_SCHEDULE_SEGUE {
            let scheduleVC = segue.destination as! ScheduleViewController
            scheduleVC.schedule = schedule
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        pleaseWait.textColor = Tracker.mode ? .white : .black
        backgroundView.backgroundColor = Tracker.mode ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        pleaseWait.textColor = Tracker.mode ? .white : .black
    }
}

//MARK: - ScheduleManagerDelegate

extension LoadingViewController: ScheduleManagerDelegate {
    func didUpdate(schedule: [Int : [[PairModel]]]) {
        self.schedule = schedule
        performSegue(withIdentifier: Identifiers.GO_TO_SCHEDULE_SEGUE, sender: self)
    }
    
    func didFail() {
        performSegue(withIdentifier: Identifiers.GO_TO_ERROR_SEGUE, sender: self)
    }
}

//MARK: - GroupManagerDelegate

extension LoadingViewController: GroupManagerDelegate {
    func didFailWithGroup() {
        performSegue(withIdentifier: Identifiers.GO_TO_ERROR_SEGUE, sender: self)
    }
}
