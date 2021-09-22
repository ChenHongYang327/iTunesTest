
import Foundation

struct StoreItem: Codable {
    
    let name: String
    let artist: String
    var kind: String
    var description: String?
    var artworkURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
        case kind
        case description = "longDescription"
        case artworkURL = "artworkUrl100"
    }
}


struct SearchResponse: Codable {
    let results: [StoreItem]
}
