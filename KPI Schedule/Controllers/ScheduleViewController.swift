//
//  ScheduleViewController.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 25.01.2023.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    let pairs = Pairs()
    
    let pairs2 = ["One", "Two", "Three"]
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentBar: UISegmentedControl!
    
    override func viewDidLoad() {
        tableView.dataSource = self
    }
    
    
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        if segmentBar.selectedSegmentIndex == 0 {
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}


extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseCellIdentifier", for: indexPath)
            cell.textLabel?.text = pairs2[indexPath.row]
        
            return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pairs2.count
    }
}

