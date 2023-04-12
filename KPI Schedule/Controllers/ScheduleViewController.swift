//
//  ScheduleViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 28.01.2023.
//

import UIKit

class ScheduleViewController: UIViewController {
    //MARK: - Properties
    
    let viewController = SearchViewController()
    
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
            let a = self.schedule?[week]![day]
            for pair in a! {
                self.scheduleArray.append(pair)
                self.tableView.reloadData()
            }
        }
        self.scheduleArray.removeAll()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DayManager.delegate = self
        configureUI()
        configureTableView()
        DayManager.performRequestForCurrentInfo()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        backgroundView.backgroundColor = Tracker.mode ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.CELL_NIB_NAME, bundle: nil), forCellReuseIdentifier: Identifiers.SCHEDULE_CELL)
    }
    
    //MARK: - Actions
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Identifiers.GO_BACK_FROM_SCHEDULE, sender: self)
    }
    
    @IBAction func weeksSelectortriggered(_ sender: UISegmentedControl) {
        week = sender.selectedSegmentIndex + 1
        updateUI(week: self.week, day: self.den)
    }
    
    @IBAction func daysSelectorTriggered(_ sender: UISegmentedControl) {
        den = sender.selectedSegmentIndex
        updateUI(week: self.week, day: self.den)
    }
}

//MARK: - ВАperformRequestForCurrentInfo

extension ScheduleViewController: CurrentDayDelegate {
    
    func didFailWithCurrentInfo() {
        print("ERROR")
    }
    
    func setCurrentDayWeekLesson(day: Int, lesson: Int) {
        self.daysSelector.selectedSegmentIndex = day - 1
        self.daysSelector.sendActions(for: .valueChanged)
        CurrentInfoDB.day = day
        CurrentInfoDB.lesson = lesson
    }
}

//MARK: - UITableViewDelegate & DataSource

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.SCHEDULE_CELL, for: indexPath) as! ScheduleCell
        let cellText = scheduleArray[indexPath.row]
        
        tableView.backgroundColor = Tracker.mode ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        if (CurrentLesson.lessonTime[CurrentInfoDB.lesson] == cellText.time
            && daysSelector.selectedSegmentIndex == CurrentInfoDB.day - 1)
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
        self.performSegue(withIdentifier: Identifiers.GO_TO_ERROR_SEGUE, sender: self)
    }
}
