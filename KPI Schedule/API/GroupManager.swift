
import Foundation


protocol GroupManagerDelegate {
    func didFailWithGroup()
}

struct GroupManager {
    
    static var delegate: ScheduleManagerDelegate?
    
    static func performRequestForGroup(group: String, completion: @escaping(GroupModel) -> ()) {
        if let url = URL(string: Urls.URL_FOR_ID) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        print("Error getting group - \(error.localizedDescription)")
                        delegate?.didFail()
                        return
                    }                }
                if let safeData = data {
                    if let group = self.parseJSON(data: safeData, group: group) {
                        DispatchQueue.main.async {
                            completion(group)
                        }
                    } else {
                        DispatchQueue.main.async {
                            delegate?.didFail()
                        }
                    }
                }
            }
            .resume()
        }
    }
    
    static func parseJSON(data: Data, group: String) -> GroupModel? {
        do {
            let decodedData = try JSONDecoder().decode(GroupData.self, from: data)
            for groupa in decodedData.data {
                if groupa.name == group {
                    return GroupModel(name: groupa.name, faculty: groupa.faculty, id: groupa.id)
                }
            }
        } catch {
            DispatchQueue.main.async {
                delegate?.didFail()
            }
        }
        return nil
    }
}
