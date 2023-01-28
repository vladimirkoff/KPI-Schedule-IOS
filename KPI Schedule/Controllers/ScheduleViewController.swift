//
//  ScheduleViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 28.01.2023.
//

import UIKit

class ScheduleViewController: UIViewController, ScheduleManagerDelegate, UITableViewDataSource {
    
    
    
    var groupManager = GroupManager()
    var group = "x"
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var schedule: [ScheduleModel] = [
        ScheduleModel(name: "ASD", type: "LAB", time: "10.25", day: "Mon", teacherName: "Molchanova"),
        ScheduleModel(name: "Matan", type: "LEK", time: "11.00", day: "Tue", teacherName: "Vaneeva"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "ASD", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "MATAN", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Sat", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Thur", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Fri", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
        ScheduleModel(name: "OP", type: "LEK", time: "8.30", day: "Wed", teacherName: "Shems"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.groupManager.delegate = self
        groupManager.performRequest(group: group)
        
        tableView.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: UrlsAndStrings.cellIdentifier)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
func didUpdate(schedule: ScheduleModel) {
    DispatchQueue.main.async {
        print(schedule.type)
        print(schedule.teacherName)
        print(schedule.time)
        print(schedule.day)
        print(schedule.name)
      }
  }
    func didFail(error: Error) {
        print("Error")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UrlsAndStrings.cellIdentifier, for: indexPath)
        as! ScheduleCell
        cell.pairLabel?.text = schedule[indexPath.row].name
        cell.dayLabel?.text = schedule[indexPath.row].day
        return cell
    }
}


