
import Foundation

private var scheduleManager = ScheduleManager()

struct GroupManager {
    
    var delegate: ScheduleManagerDelegate?
    
    func performRequest(group: String) {
        if let url = URL(string: UrlsAndStrings.urlForId) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    self.delegate?.didFail(error: e)
                }
                if let safeData = data {
                    if let grouppa = self.parseJSON(data: safeData, group: group) {
                          scheduleManager.performRequest(id: grouppa.id, delegate: delegate)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(data: Data, group: String) -> GroupModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(GroupData.self, from: data)
            for groupa in decodedData.data {
                if groupa.name == group {
                    return GroupModel(name: groupa.name, faculty: groupa.faculty, id: groupa.id)
                }
            }
        } catch {
            self.delegate?.didFail(error: error)
        }
        return nil
    }
}
