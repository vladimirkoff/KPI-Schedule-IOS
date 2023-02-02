//
//  ScheduleCell.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 28.01.2023.
//

import UIKit

class ScheduleCell: UITableViewCell {

    @IBOutlet var backGround: UIView!
    @IBOutlet var backgroundCol: UIView!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundCol.backgroundColor = Tracker.mode ? #colorLiteral(red: 0.2078431373, green: 0.3137254902, blue: 0.4392156863, alpha: 1) : #colorLiteral(red: 0.7764705882, green: 0.6745098039, blue: 0.5607843137, alpha: 1)
        changeTextColor(mode: Tracker.mode)
    }
    func changeTextColor(mode: Bool) {
        if mode {
            teacherNameLabel.textColor = .white
            nameLabel.textColor = .white
            typeLabel.textColor = .white
            timeLabel.textColor = .white
        } else {
            teacherNameLabel.textColor = .black
            nameLabel.textColor = .black
            typeLabel.textColor = .black
            timeLabel.textColor = .black
        }
    }
}
    

