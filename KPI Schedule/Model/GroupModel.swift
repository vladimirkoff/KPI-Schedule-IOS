//
//  GroupModel.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 12.04.2023.
//

import Foundation

struct GroupData: Codable {
    var data: [Group]
}

struct Group: Codable {
    var name: String
    var faculty: String
    var id: String
}
