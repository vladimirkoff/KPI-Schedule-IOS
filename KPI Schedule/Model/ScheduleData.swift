//
//  ScheduleData.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 25.01.2023.
//

import Foundation


    struct GroupData: Codable {
        let data: [GroupInfo]
    }
    
    struct ScheduleData: Codable {
        let data: FirstWeek
    }
    
    struct CurrentTimeAndDateData: Codable {
        let year: Int
        let day: Int
        let hour: Int
        let minute: Int
        let dayOfWeek: String
        let seconds: Int
    }
    
    struct CurrentLessonAndweekData: Codable {
        let data: CurrentInfo
    }



    
    
    
    struct CurrentInfo: Codable {
        let currentWeek: Int
        let currentDay: Int
        let currentLesson: Int
    }
    
    struct GroupInfo: Codable {
        let name: String
        let id: String
        let faculty: String
    }
    
    
    struct FirstWeek: Codable {
        let scheduleFirstWeek: [Day]
    }
    
    struct SecondWeek: Codable {
        let scheduleSecondtWeek: [Day]
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
    
    
