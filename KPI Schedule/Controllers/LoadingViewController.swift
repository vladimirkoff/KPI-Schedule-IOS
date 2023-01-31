//
//  LoadingViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 31.01.2023.
//

import UIKit

class LoadingViewController: UIViewController, ScheduleManagerDelegate, GroupManagerDelegate {
    
    var group = "x"
    
    var schedule: [Int : [[PairModel]]]?
    
    func didFailWithGroup() {
        self.performSegue(withIdentifier: "goToError", sender: self)
    }
    
    
    func didUpdate(schedule: [Int : [[PairModel]]]) {
//        DispatchQueue.main.async {
//            for pair in schedule[self.week]![self.den] {
//                self.schedule.append(pair)
//                self.tableView.reloadData()
//            }
//        }
//    self.schedule.removeAll()
        self.schedule = schedule
        self.performSegue(withIdentifier: UrlsAndSchedule.segueIdentifier, sender: self)
    }
    
    func didFail(error: Error) {
        self.performSegue(withIdentifier: "goToError", sender: self)
    }
   
    
    
    var groupManager = GroupManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        groupManager.delegate = self
        groupManager.del = self
        groupManager.performRequest(group: group)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSchedule" {
            let scheduleVC = segue.destination as! ScheduleViewController
            scheduleVC.test = self.schedule
        }
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
