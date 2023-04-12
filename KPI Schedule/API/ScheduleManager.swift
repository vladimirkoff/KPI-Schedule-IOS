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
        do {
            let decodedData = try JSONDecoder().decode(ScheduleData.self, from: data)
            var schedule = [1: [[PairModel]](), 2: [[PairModel]]()]
            
            let fetchedSchedule = fetchSchedule(firstWeek: decodedData.data.scheduleFirstWeek, secondWeek: decodedData.data.scheduleSecondWeek)
            
            schedule[1] = fetchedSchedule[0]
            schedule[2] = fetchedSchedule[1]
            
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
    
    //MARK: - Fetch schedule for 2 weeks
    
    static func fetchSchedule(firstWeek: [Day], secondWeek: [Day] ) -> [[[PairModel]]] {
        var schedule = [[[PairModel]]]()
        var days = [Day]()
        var day = 0
        var scheduleForWeek = [[PairModel]]()
        
        for week in 1...2 {
            day = 0
            days = week == 1 ? firstWeek : secondWeek
            scheduleForWeek = week == 1 ? ScheduleForWeeks.firstWeek : ScheduleForWeeks.secondWeek
            for weekDay in days {
                for para in weekDay.pairs {
                    let name = para.name
                    let teacherName = para.teacherName
                    let time = para.time
                    let type = para.type
                    scheduleForWeek[day].append(PairModel(name: name, type: type, time: time, teacherName: teacherName))
                }
                day += 1
            }
            schedule.append(scheduleForWeek)
        }
        return schedule
    }
}
