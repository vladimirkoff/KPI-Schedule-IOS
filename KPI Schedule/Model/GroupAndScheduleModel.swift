//
//  GroupModel.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 27.01.2023.
//

import Foundation

struct GroupModel {
    var name: String
    var faculty: String
    var id: String 
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
