//
//  ScheduleManager.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 27.01.2023.
//

import Foundation

protocol ScheduleManagerDelegate {
    func didUpdate(schedule: ScheduleModel)
    func didFail(error: Error)
}

struct ScheduleManager {
    
    func performRequest(id: String, delegate: ScheduleManagerDelegate?) {
        UrlsAndStrings.urlForSchedule += id
        
        if let url = URL(string: UrlsAndStrings.urlForSchedule) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    delegate?.didFail(error: e)
                }
                if let safeData = data {
                    if let schedule = self.parse2JSON(data: safeData) {
                        DispatchQueue.main.async {
                            delegate?.didUpdate(schedule: schedule)
                        }
                    }
                }
            }
            UrlsAndStrings.urlForSchedule = "https://schedule.kpi.ua/api/schedule/lessons?groupId="
            task.resume()
        }
    }
    
    func parse2JSON(data: Data) -> ScheduleModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(ScheduleData.self, from: data)
            let name = decodedData.data.scheduleFirstWeek[0].pairs[0].name
            let teacherName = decodedData.data.scheduleFirstWeek[0].pairs[0].teacherName
            let time = decodedData.data.scheduleFirstWeek[0].pairs[0].time
            let day = decodedData.data.scheduleFirstWeek[0].day
            let type = decodedData.data.scheduleFirstWeek[0].pairs[0].type
            return ScheduleModel(name: name, type: type, time: time, day: day, teacherName: teacherName)
        } catch {
            print("Error occured")
        }
        return nil
    }
}
