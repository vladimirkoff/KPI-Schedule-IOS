//
//  ScheduleViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 28.01.2023.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    let viewController = ViewController()
    var groupManager = GroupManager()
    var group = "x"
    var week = 1
    var den = 0
    var schedule: [PairModel] = []
    var test: [Int : [[PairModel]]]?
    
    
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var daysSelector: UISegmentedControl!
    @IBOutlet weak var weeksSeelctor: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    func Test() {
        DispatchQueue.main.async {
            let a = self.test?[self.week]![self.den]
            for pair in a! {
                self.schedule.append(pair)
                self.tableView.reloadData()
            }
        }
    self.schedule.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Test()
//        groupManager.del = self
//        groupManager.delegate = self
        tableView.dataSource = self
//        groupManager.performRequest(group: group)
        tableView.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: UrlsAndSchedule.cellIdentifier)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func weeksSelectortriggered(_ sender: UISegmentedControl) {
        week = sender.selectedSegmentIndex + 1
//        groupManager.performRequest(group: group)
        Test()
    }
    
    @IBAction func daysSelectorTriggered(_ sender: UISegmentedControl) {
        den = sender.selectedSegmentIndex
//        groupManager.performRequest(group: group)
        Test()
    }
}

//MARK: - UITableView

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UrlsAndSchedule.cellIdentifier, for: indexPath)
        as! ScheduleCell
        cell.timeLabel?.text = schedule[indexPath.row].time
        cell.typeLabel?.text = schedule[indexPath.row].type
        cell.nameLabel?.text = schedule[indexPath.row].name
        cell.teacherNameLabel?.text = schedule[indexPath.row].teacherName
        return cell
    }
}

//MARK: - ScheduleManager

//extension ScheduleViewController: ScheduleManagerDelegate {
//    func didUpdate(schedule: [Int : [[PairModel]]]) {
//        DispatchQueue.main.async {
//            for pair in schedule[self.week]![self.den] {
//                self.schedule.append(pair)
//                self.tableView.reloadData()
//            }
//        }
//    self.schedule.removeAll()
//  }
//    func didFail(error: Error) {
//        print("Error")
//    }
//}

//MARK: - GroupManager

extension ScheduleViewController: GroupManagerDelegate {
    func didFailWithGroup() {
        print("An error occured")
        self.performSegue(withIdentifier: "goToError", sender: self)
    }
}
