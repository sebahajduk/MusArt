
import Foundation



class NetworkManager: ObservableObject {
    @Published var art = [Art]()
    @Published var objectIDs = [Int]()
    @Published var totalArts = Int()
    func loadData() {
        
        if let url = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/objects") {
            let session = URLSession(configuration: .default)
            let objectsArray = session.dataTask(with: url) { (data, response, error) in
                
                if let e = error {
                    print(e)
                } else {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(ObjectsID.self, from: safeData)
                            DispatchQueue.main.async {
                                
                                self.objectIDs = results.objectIDs
                                self.totalArts = results.total
                                
                                self.loadArt()
                                print(self.art)
                                
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
                
            }
            objectsArray.resume()
        }
        
    }
    
    func loadArt() {
        
        
        if objectIDs.count > 1 {
            
            let n = Int.random(in: 0...totalArts)
            
            if let url = URL(string:"https://collectionapi.metmuseum.org/public/collection/v1/objects/\(objectIDs[n])") {
                let session = URLSession(configuration: .default)
                let art = session.dataTask(with: url) { (data, response, error) in
                    
                    if let e = error {
                        print(e)
                    } else {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                let result = try decoder.decode(Art.self, from: safeData)
                                DispatchQueue.main.async {
                                  
                                        self.art.append(result)
                                }
                            } catch {
                                print(error)
                            }
                        }
                    }
                    
                }
                art.resume()
                
            }
            }
        
    }
    
}
