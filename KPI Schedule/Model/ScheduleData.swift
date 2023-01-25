//
//  ScheduleData.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 25.01.2023.
//

import Foundation

struct ScheduleData: Codable {
     let data: [GroupInfo]
}

struct ScheduleData2: Codable {
    let data: FirstWeek
}

struct GroupInfo: Codable {
    let name: String
    let id: String
    let faculty: String
}



struct FirstWeek: Codable {
    let scheduleFirstWeek: [Day]
}

struct Day: Codable {
    let day: String
    let pairs: [Pair]
}

struct Pair: Codable {
    let teacherName: String
    let type: String
    let time: String
    let name: String
}
