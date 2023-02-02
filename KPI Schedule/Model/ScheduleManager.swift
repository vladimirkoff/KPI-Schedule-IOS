//
//  ScheduleManager.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 27.01.2023.
//

import Foundation

protocol ScheduleManagerDelegate {
    func didUpdate(schedule: [Int : [[PairModel]]])
    func didFail(error: Error)
}

struct ScheduleManager {

     func performRequestForSchedule(id: String, delegate: ScheduleManagerDelegate?) {
        let del = delegate
        DispatchQueue.global().async {
            Urls.urlForSchedule += id
            
            if let url = URL(string: Urls.urlForSchedule) {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if let e = error {
                        delegate?.didFail(error: e)
                    }
                    if let safeData = data {
                        if let schedule = self.parse2JSON(data: safeData, delegate: del) {
                            DispatchQueue.main.async {
                                delegate?.didUpdate(schedule: schedule)
                                ScheduleForWeeks.updateWeeks()
                            }
                        }
                    }
                }
                Urls.updateURL()
                task.resume()
            }
        }
        
    }
    
    func parse2JSON(data: Data, delegate: ScheduleManagerDelegate?) -> [Int : [[PairModel]]]? {
        let decoder = JSONDecoder()
        var den = 0
        do {
            let decodedData = try decoder.decode(ScheduleData.self, from: data)
            var schedule = [1: [[PairModel]](), 2: [[PairModel]]()]
            for day in decodedData.data.scheduleFirstWeek {
                for para in day.pairs {
                    let name = para.name
                    let teacherName = para.teacherName
                    let time = para.time
                    let type = para.type
                    ScheduleForWeeks.firstWeek[den].append(PairModel(name: name, type: type, time: time, teacherName: teacherName))
                }
                den += 1
            }
            schedule[1] = ScheduleForWeeks.firstWeek
            den = 0
            for day in decodedData.data.scheduleSecondWeek {
                for para in day.pairs {
                    let name = para.name
                    let teacherName = para.teacherName
                    let time = para.time
                    let type = para.type
                    ScheduleForWeeks.secondWeek[den].append(PairModel(name: name, type: type, time: time, teacherName: teacherName))
                }
                den += 1
        }
            schedule[2] = ScheduleForWeeks.secondWeek
            return schedule
        } catch {
            delegate?.didFail(error: error)
        }
        return nil
    }
}
