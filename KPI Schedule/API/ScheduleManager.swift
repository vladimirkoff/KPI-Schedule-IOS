//
//  ScheduleManager.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 27.01.2023.
//

import Foundation

protocol ScheduleManagerDelegate {
    func didUpdate(schedule: [Int : [[PairModel]]])
    func didFail()
}

struct ScheduleManager {
    
    static var delegate: ScheduleManagerDelegate?
    
    static func performRequestForSchedule(id: String) {
        
        let url = URL(string: Urls.URL_FOR_SCHEDULE + id)
        
        if let url = url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error getting schedule - \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        delegate?.didFail()
                    }
                    return
                }
                if let safeData = data {
                    if let schedule = self.parseJSON(data: safeData) {
                        DispatchQueue.main.async {
                            delegate?.didUpdate(schedule: schedule)
                        }
                    }
                }
            }
            .resume()
        }
    }
    
    static  func parseJSON(data: Data) -> [Int : [[PairModel]]]? {
        var den = 0
        do {
            let decodedData = try JSONDecoder().decode(ScheduleData.self, from: data)
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
            DispatchQueue.main.async {
                delegate?.didFail()
            }
        }
        DispatchQueue.main.async {
            delegate?.didFail()
        }
        return nil
    }
}
