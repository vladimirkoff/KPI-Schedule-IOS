//
//  ScheduleViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 28.01.2023.
//

import UIKit

class ScheduleViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var daysSelector: UISegmentedControl!
    @IBOutlet weak var weeksSeelctor: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var scheduleArray: [PairModel] = []
    var schedule: [Int : [[PairModel]]]?
    
    private var group = ""
    private var week = 1
    private var den = 0
    
    
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
    
    func updateUI(week: Int, day: Int) {
        DispatchQueue.main.async {
            let schedule = self.schedule?[week]![day]
            for pair in schedule! {
                self.scheduleArray.append(pair)
                self.tableView.reloadData()
            }
        }
        scheduleArray.removeAll()
    }
    
    //MARK: - Actions
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Identifiers.GO_BACK_FROM_SCHEDULE, sender: self)
    }
    
    @IBAction func weeksSelectortriggered(_ sender: UISegmentedControl) {
        week = sender.selectedSegmentIndex + 1
        updateUI(week: week, day: den)
    }
    
    @IBAction func daysSelectorTriggered(_ sender: UISegmentedControl) {
        den = sender.selectedSegmentIndex
        updateUI(week: week, day: den)
    }
}

//MARK: - ВАperformRequestForCurrentInfo

extension ScheduleViewController: CurrentDayDelegate {
    
    func didFailWithCurrentInfo(error: Error) {
        print("ERROR getting current parameters - \(error.localizedDescription)")
    }
    
    func setCurrentDayWeekLesson(day: Int, lesson: Int) {
        daysSelector.selectedSegmentIndex = day - 1
        daysSelector.sendActions(for: .valueChanged)
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
        performSegue(withIdentifier: Identifiers.GO_TO_ERROR_SEGUE, sender: self)
    }
}
