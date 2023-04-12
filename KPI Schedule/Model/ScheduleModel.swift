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

struct PairModel {
    var name: String
    var type: String
    var time: String
    var teacherName: String
}

struct CurrentInfoDB {
    static var lesson = 0
    static var day = 0
}

//MARK: - Models for current lesson

struct CurrentData: Codable {
    var data: CurrentParams
}


struct CurrentParams: Codable {
    var currentWeek: Int
    var currentDay: Int
    var currentLesson: Int
}
