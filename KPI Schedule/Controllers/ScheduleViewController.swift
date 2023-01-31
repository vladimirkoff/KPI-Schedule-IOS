//
//  ScheduleViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 28.01.2023.
//

import UIKit

class ScheduleViewController: UIViewController, CurrentDayDelegate {
    var dayManager = DayManager()
    let viewController = ViewController()
    var groupManager = GroupManager()
    var group = "GROUP"
    var week = 1
    var den = 0
    var scheduleArray: [PairModel] = []
    var schedule: [Int : [[PairModel]]]?
    

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var daysSelector: UISegmentedControl!
    @IBOutlet weak var weeksSeelctor: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    func updateUI() {
        DispatchQueue.main.async {
            let a = self.schedule?[self.week]![self.den]
            for pair in a! {
                self.scheduleArray.append(pair)
                self.tableView.reloadData()
            }
        }
    self.scheduleArray.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayManager.delegate = self
        dayManager.performRequest()
        backgroundView.backgroundColor = Tracker.mode ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        updateUI()
        tableView.dataSource = self
        tableView.register(UINib(nibName: Strings.cellName, bundle: nil), forCellReuseIdentifier: Urls.cellIdentifier)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Strings.segue4Identifier, sender: self)
    }
    
    @IBAction func weeksSelectortriggered(_ sender: UISegmentedControl) {
        week = sender.selectedSegmentIndex + 1
        updateUI()
    }
    
    @IBAction func daysSelectorTriggered(_ sender: UISegmentedControl) {
        den = sender.selectedSegmentIndex
        updateUI()
    }
    
    func setCurrentDay(day: Int) {
        daysSelector.selectedSegmentIndex = day
    }
}

//MARK: - UITableView

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Urls.cellIdentifier, for: indexPath)
        as! ScheduleCell
        cell.timeLabel?.text = scheduleArray[indexPath.row].time
        cell.typeLabel?.text = scheduleArray[indexPath.row].type
        cell.nameLabel?.text = scheduleArray[indexPath.row].name
        cell.teacherNameLabel?.text = scheduleArray[indexPath.row].teacherName
        return cell
    }
}

//MARK: - GroupManager

extension ScheduleViewController: GroupManagerDelegate {
    func didFailWithGroup() {
        print("An error occured")
        self.performSegue(withIdentifier: Strings.segue2Identifier, sender: self)
    }
}
