//
//  CurrentLessonAndWeek.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 26.01.2023.
//

import Foundation

struct CurrentLessonAndWeek {
    let testURL = "https://schedule.kpi.ua/api/time/current"
    
    func performRequest() {
        if let url = URL(string: testURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    print(e)
                } else {
                    if let safeData = data {
                        if let test = parseJSON(data: safeData) {
                            print(test.data.currentWeek)
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> CurrentLessonAndweekData? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CurrentLessonAndweekData.self, from: data)
            return decodedData
        } catch {
            print("Error 4")
            return nil
        }
    }
}
