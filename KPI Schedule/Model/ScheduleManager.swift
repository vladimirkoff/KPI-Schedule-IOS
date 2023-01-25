//
//  ScheduleManager.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 25.01.2023.
//

import Foundation

struct ScheduleManager {
    var urlForSchedule = "https://schedule.kpi.ua/api/schedule/lessons?groupId="
    
    mutating func performRequest(for id: String) {
        urlForSchedule += id
        
        if let url = URL(string: urlForSchedule) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    print(e)
                } else {
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        
                        do {
                            let decodedData = try decoder.decode(ScheduleData2.self, from: safeData)
                            let days = decodedData.data.scheduleFirstWeek
                            
                            for day in days {
                                print (day.day)
                                for pair in day.pairs {
                                    print(pair.name)
                                    print(pair.teacherName)
                                    print(pair.time)
                                    print(pair.type)
                                    print("--------")
                                }
                            }
//                            print(decodedData.data.scheduleFirstWeek[0].pairs[0].name)
//                            print(decodedData.data.scheduleFirstWeek[0].pairs[0].time)
//                            print(decodedData.data.scheduleFirstWeek[0].pairs[0].type)
//                            print(decodedData.data.scheduleFirstWeek[0].pairs[0].teacherName)
                        } catch {
                            print("Error 2")
                        }
                    }
                }
            }
            urlForSchedule = "https://schedule.kpi.ua/api/schedule/lessons?groupId="
            task.resume()
        }
    }
    
//    func parseJSON(data: Data, id: String) -> String? {
//        let decoder = JSONDecoder()
//
//        do {
//            let decodedData = try decoder.decode(ScheduleData2.self, from: data)
//            let day = decodedData.data.scheduleFirstWeek[0].day
//            return day
//        } catch {
//            print("Error")
//            return nil
//        }
//    }
}
