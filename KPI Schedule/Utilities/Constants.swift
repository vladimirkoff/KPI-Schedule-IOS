//
//  Test.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 27.01.2023.
//

import Foundation

struct Urls {
    static let URL_FOR_ID = "https://schedule.kpi.ua/api/schedule/groups"
    static var URL_FOR_SCHEDULE = "https://schedule.kpi.ua/api/schedule/lessons?groupId="
    static var URL_FOR_CURRENT_INFO = "https://schedule.kpi.ua/api/time/current"
    static func updateURL() {
        URL_FOR_SCHEDULE = "https://schedule.kpi.ua/api/schedule/lessons?groupId="
    }
}

struct Identifiers {
    static let GO_TO_SCHEDULE_SEGUE = "goToSchedule"
    static let GO_TO_LOADING_SEGUE = "goToLoading"
    static let GO_TO_ERROR_SEGUE = "goToError"
    static let GO_BACK_SEGUE = "goBackToInit"
    static let GO_BACK_FROM_SCHEDULE = "goBackFromSchedule"
    static let SCHEDULE_CELL = "ReusableCell"
    static let CELL_NIB_NAME = "ScheduleCell"
}


