//
//  ScheduleManager.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 25.01.2023.
//

import Foundation

var schedule = ScheduleManager()

struct GroupManager {
    let urlForId = "https://schedule.kpi.ua/api/schedule/groups"

    func performRequest(for group: String) {
        if let url = URL(string: urlForId) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    print(e)
                } else {
                    if let safeData = data {
                        if let id = parseJSON(data: safeData, group: group) {
                            print(id)
                            schedule.performRequest(for: id)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data, group: String) -> String? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(GroupData.self, from: data)
            for name in decodedData.data {
                if name.name == group {
                    return name.id
                }
            }
        } catch {
            print("Error 1")
        }
        return nil
    }
}
