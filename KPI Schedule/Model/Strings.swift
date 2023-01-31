//
//  Test.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 27.01.2023.
//

import Foundation

struct Urls {
    static let urlForId = "https://schedule.kpi.ua/api/schedule/groups"
    static var urlForSchedule = "https://schedule.kpi.ua/api/schedule/lessons?groupId="
    static var urlForCurrentInfo = "https://schedule.kpi.ua/api/time/current"
    static let segueIdentifier = "goToSchedule"
    static let cellIdentifier = "ReusableCell"
    static func updateURL() {
        urlForSchedule = "https://schedule.kpi.ua/api/schedule/lessons?groupId="
    }
}

struct Strings {
    static let segueIdentifier = "goToSchedule"
    static let segue1Identifier = "goToLoading"
    static let segue2Identifier = "goToError"
    static let segue3Identifier = "goBackToInit"
    static let segue4Identifier = "goBackFromSchedule"
    static let cellIdentifier = "ReusableCell"
    static let cellName = "ScheduleCell"
}

struct ScheduleForWeeks {
    static var firstWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), ]
    static var secondWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](),]
    static func updateWeeks() {
        firstWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), ]
        secondWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](),]
    }
}
