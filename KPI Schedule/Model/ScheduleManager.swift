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
    
    func performRequest(id: String, delegate: ScheduleManagerDelegate?) {
        DispatchQueue.global().async {
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
                                Test.firstWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), ]
                                Test.secondWeek = [[PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), [PairModel](), ]
                            }
                        }
                    }
                }
                UrlsAndStrings.urlForSchedule = "https://schedule.kpi.ua/api/schedule/lessons?groupId="
                task.resume()
            }
        }
        
    }
    
    func parse2JSON(data: Data) -> [Int : [[PairModel]]]? {
        let decoder = JSONDecoder()
        var den = 0
        do {
            let decodedData = try decoder.decode(ScheduleData.self, from: data)
            var test = [1: [[PairModel]](), 2: [[PairModel]]()]
            for day in decodedData.data.scheduleFirstWeek {
                for para in day.pairs {
                    let name = para.name
                    let teacherName = para.teacherName
                    let time = para.time
                    let type = para.type
                    Test.firstWeek[den].append(PairModel(name: name, type: type, time: time, teacherName: teacherName))
                }
                den += 1
                            }
          
            test[1] = Test.firstWeek
            den = 0
            for day in decodedData.data.scheduleSecondWeek {
                for para in day.pairs {
                    let name = para.name
                    let teacherName = para.teacherName
                    let time = para.time
                    let type = para.type
                    Test.secondWeek[den].append(PairModel(name: name, type: type, time: time, teacherName: teacherName))
                }
                den += 1
        }
            test[2] = Test.secondWeek
           
            return test
        } catch {
            print("Error occured")
        }
        return nil
    }
}
