//
//  ScheduleModel.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 12.04.2023.
//

import Foundation

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

//MARK: - Models for current lesson

struct CurrentData: Codable {
    var data: CurrentObjs
}


struct CurrentObjs: Codable {
    var currentWeek: Int
    var currentDay: Int
    var currentLesson: Int
}
