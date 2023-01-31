//
//  Test.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 27.01.2023.
//

import Foundation

struct UrlsAndSchedule {
    static let urlForId = "https://schedule.kpi.ua/api/schedule/groups"
    static var urlForSchedule = "https://schedule.kpi.ua/api/schedule/lessons?groupId="
    static let segueIdentifier = "goToSchedule"
    static let cellIdentifier = "ReusableCell"
    static func updateURL() {
        urlForSchedule = "https://schedule.kpi.ua/api/schedule/lessons?groupId="
    }
}

struct ScheduleForWeeks {
    static var firstWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), ]
    static var secondWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](),]
    static func updateWeeks() {
        firstWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), ]
        secondWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](),]
    }
}
