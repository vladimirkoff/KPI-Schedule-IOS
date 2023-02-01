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
    
    var scheduleArray: [PairModel] = []
    var schedule: [Int : [[PairModel]]]?
    
    var group = "GROUP"
    var week = 1
    var den = 0

    
    
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var daysSelector: UISegmentedControl!
    @IBOutlet weak var weeksSeelctor: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    func updateUI(week: Int, day: Int) {
        DispatchQueue.main.async {
            print(day)
            let a = self.schedule?[week]![day]
            for pair in a! {
                self.scheduleArray.append(pair)
                self.tableView.reloadData()
            }
        }
    self.scheduleArray.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(week: 1, day: 1)
        dayManager.delegate = self
        tableView.dataSource = self
        backgroundView.backgroundColor = Tracker.mode ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        tableView.register(UINib(nibName: Strings.cellName, bundle: nil), forCellReuseIdentifier: Urls.cellIdentifier)
        dayManager.performRequest()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Strings.segue4Identifier, sender: self)
    }
    
    @IBAction func weeksSelectortriggered(_ sender: UISegmentedControl) {
        week = sender.selectedSegmentIndex+1
        updateUI(week: self.week, day: self.den)
    }
    
    @IBAction func daysSelectorTriggered(_ sender: UISegmentedControl) {
        print("Changed")
        den = sender.selectedSegmentIndex
        updateUI(week: self.week, day: self.den)
    }
    func setCurrentDayWeekLesson(day: Int, lesson: Int) {
        
        DispatchQueue.main.async {
            self.daysSelector.selectedSegmentIndex = day-1
            self.daysSelector.sendActions(for: .valueChanged)
            CurrentInfoDB.day = day
            CurrentInfoDB.lesson = lesson
        }
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
        let cellText = scheduleArray[indexPath.row]
        
        if (CurrentLesson.lessonTime[CurrentInfoDB.lesson] == cellText.time
            && daysSelector.selectedSegmentIndex == CurrentInfoDB.day-1)
            {cell.timeLabel?.text = "\(cellText.time)   🔴NOW"} else {cell.timeLabel?.text = cellText.time}
        cell.typeLabel?.text = cellText.type
        cell.nameLabel?.text = cellText.name
        cell.teacherNameLabel?.text = cellText.teacherName
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
