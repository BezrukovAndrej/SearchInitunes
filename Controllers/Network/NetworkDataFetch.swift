import UIKit

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchAlbum(urlSting: String, responce: @escaping (AlbumModel?, Error?) -> Void) {
        
        NetworkRequest.shared.requestData(urlString: urlSting) { result  in
            switch result {
            case .success(let data):
                do {
                    let albums = try? JSONDecoder().decode(AlbumModel.self, from: data)
                    responce(albums, nil)
                } catch let jsonError {
                    print("Failed to decode JSON" , jsonError)
                }
            case .failure(let error):
                print("Error received reuesting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
    
    func fetchSongs(urlSting: String, responce: @escaping (SongsModel?, Error?) -> Void) {
        
        NetworkRequest.shared.requestData(urlString: urlSting) { result  in
            switch result {
            case .success(let data):
                do {
                    let songs = try? JSONDecoder().decode(SongsModel.self, from: data)
                    responce(songs, nil)
                } catch let jsonError {
                    print("Failed to decode JSON" , jsonError)
                }
            case .failure(let error):
                print("Error received reuesting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
