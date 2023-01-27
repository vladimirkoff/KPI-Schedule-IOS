//
//  GroupModel.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 27.01.2023.
//

import Foundation

struct GroupData: Codable {
    var data: [Group]
}

struct ScheduleData: Codable {
    var data: Schedule
}





struct Schedule: Codable {
    var scheduleFirstWeek: [Day]
    var scheduleSecondWeek: [Day]
}

struct Day: Codable {
    var day: String
    var pairs: [Pair]
}

struct Pair: Codable {
    var teacherName: String
    var type: String
    var name: String
    var time: String
}

struct Group: Codable {
    var name: String
    var faculty: String
    var id: String
}
