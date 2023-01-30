//
//  ScheduleViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 28.01.2023.
//

import UIKit

class ScheduleViewController: UIViewController, ScheduleManagerDelegate, UITableViewDataSource {
    
    
    var week = 1
    var den = 0
    @IBOutlet weak var daysSelector: UISegmentedControl!
    @IBOutlet weak var weeksSeelctor: UISegmentedControl!
    
    var groupManager = GroupManager()
    var group = "x"
    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var schedule: [PairModel] = []
    
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
    
func didUpdate(schedule: [Int : [[PairModel]]]) {
    DispatchQueue.main.async {
        for pair in schedule[self.week]![self.den] {
            self.schedule.append(pair)
            self.tableView.reloadData()
        }
    }
    self.schedule.removeAll()
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
        cell.timeLabel?.text = schedule[indexPath.row].time
        cell.typeLabel?.text = schedule[indexPath.row].type
        cell.nameLabel?.text = schedule[indexPath.row].name
        cell.teacherNameLabel?.text = schedule[indexPath.row].teacherName
        return cell
    }
    
    
    @IBAction func weeksSelectortriggered(_ sender: UISegmentedControl) {
        week = sender.selectedSegmentIndex + 1
        groupManager.performRequest(group: group)
    }
    
    @IBAction func daysSelectorTriggered(_ sender: UISegmentedControl) {
        den = sender.selectedSegmentIndex + 1
        groupManager.performRequest(group: group)
    }
    
}


