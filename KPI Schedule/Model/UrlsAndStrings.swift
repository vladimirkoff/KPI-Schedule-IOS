//
//  Test.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 27.01.2023.
//

import Foundation

struct UrlsAndStrings {
    static let urlForId = "https://schedule.kpi.ua/api/schedule/groups"
    static var urlForSchedule = "https://schedule.kpi.ua/api/schedule/lessons?groupId="
    static let segueIdentifier = "goToSchedule"
    static let cellIdentifier = "ReusableCell"
}

struct Test {
    static var firstWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), ]
    static var secondWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](),]
}
