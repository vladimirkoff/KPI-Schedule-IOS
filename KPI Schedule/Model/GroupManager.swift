
import Foundation



var scheduleManager = ScheduleManager()

struct GroupManager {
    let url = "https://schedule.kpi.ua/api/schedule/groups"
    
    
    func performRequest(group: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    print(e)
                }
                if let safeData = data {
                    if let grouppa = self.parseJSON(data: safeData, group: group) {
//                        self.delegate?.didUpdate(group: grouppa)
                          scheduleManager.performRequest(id: grouppa.id)
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
            print("Error")
        }
        return nil
    }
}
