//
//  CurrentData.swift
//  KPI Schedule
//
//  Created by Vladimir Kovalev on 26.01.2023.
//

import Foundation

struct CurrentTimeAndDate {
    let urlForCurrentData = "https://timeapi.io/api/Time/current/zone?timeZone=Europe/Kiev"
    
    func performRequest() {
        if let url = URL(string: urlForCurrentData) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    print(e)
                } else {
                    if let safeData = data {
                        if let obj = parseJSON(data: safeData) {
                            print(obj)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(data: Data) -> CurrentTimeAndDateData? {
        let decoder = JSONDecoder()
    
        do {
            let decodedData = try decoder.decode(CurrentTimeAndDateData.self, from: data)
            return decodedData
        } catch {
            print("Error 3")
            return nil
        }
    }
}
