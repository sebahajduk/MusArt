

import Foundation
import SwiftUI


struct Art: Decodable, Identifiable {
    let objectID: Int
    var id: Int {
        return objectID
    }
    
    let title: String
    let artistDisplayName: String
    
}

struct ObjectsID: Decodable {
    let total: Int
    let objectIDs: [Int]
    
}
