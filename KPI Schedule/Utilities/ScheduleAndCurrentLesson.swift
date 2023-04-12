//
//  ScheduleAndCurrentLesson.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 12.04.2023.
//

import Foundation

struct ScheduleForWeeks {
    static var firstWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel]()]
    static var secondWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel]()]
}

struct CurrentLesson {
    static let lessonTime = [
        1: "8.30",
        2: "10.25",
        3: "12.20",
        4: "14.15",
        5: "16.10",
        6: "18.30",
    ]
}
