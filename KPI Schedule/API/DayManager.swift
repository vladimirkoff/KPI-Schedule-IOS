//
//  DayManager.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 31.01.2023.
//

import Foundation

protocol CurrentDayDelegate {
    func setCurrentDayWeekLesson(day: Int, lesson: Int)
    func didFailWithCurrentInfo(error: Error)
}

struct DayManager {
    
    static var delegate: CurrentDayDelegate?
    
    static func performRequestForCurrentInfo() {
        if let url = URL(string: Urls.URL_FOR_CURRENT_INFO) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let safeData = data {
                    if let current = parseJSON(data: safeData){
                        DispatchQueue.main.async {
                            self.delegate?.setCurrentDayWeekLesson(day: current[0], lesson: current[1])
                        }
                    }
                }
            }
            .resume()
        }
    }
    
    static  func parseJSON(data: Data) -> [Int]? {
        do {
            let decodedData =  try JSONDecoder().decode(CurrentData.self, from: data)
            return [decodedData.data.currentDay, decodedData.data.currentLesson]
        } catch {
            delegate?.didFailWithCurrentInfo(error: error)
        }
        return nil
    }
}
