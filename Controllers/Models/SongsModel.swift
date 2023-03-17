import UIKit


struct SongsModel: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?
}
