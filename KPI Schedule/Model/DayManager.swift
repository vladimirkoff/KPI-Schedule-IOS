//
//  DayManager.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 31.01.2023.
//

import Foundation

protocol CurrentDayDelegate {
    func setCurrentDay(day: Int)
}

struct DayManager {
    
    var delegate: CurrentDayDelegate?
    func performRequest() {
        if let url = URL(string: Urls.urlForCurrentInfo) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    print(e)
                }
                if let safeData = data {
                        if let day = parseJSON(data: safeData){
                            DispatchQueue.main.async {
                                self.delegate?.setCurrentDay(day: day)
                            }
                            

                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(data: Data) -> Int? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(CurrentInfo.self, from: data)
            return decodedData.data.currentDay
        } catch {
            print("Error in current data")
        }
        return nil
    }
}
