

import Foundation
import UIKit

class StoreItemController {
    static let shard = StoreItemController()
    
    func fetchItems (term: String, media: String, lang: String, limit: Int, completion: @escaping ([StoreItem]?) -> Void){
        
        // url 方法1
//        let url = URL(string: "https://itunes.apple.com/search?term=\(term)&media=\(media)&lang=\(lang)&limit=\(limit)")
        
        
        // url 方法2 : 
        let baseURL = URL(string: "https://itunes.apple.com/search")!

        var conponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        conponents?.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "media", value: media),
            URLQueryItem(name: "lang", value: lang),
            URLQueryItem(name: "limit", value: String(limit))
        ]
        let url = conponents?.url
    
        URLSession.shared.dataTask(with: url!) { data, reponce, error in
            
            if let data = data {
                // 要解碼
                let decoder = JSONDecoder()
                do {
                    let searchResponce = try decoder.decode(SearchResponse.self, from: data)
                    completion(searchResponce.results)
                } catch {
                   // print(error)
                    completion(nil)
                }
            }
        }.resume()
        
    }
    
    
    func fetchImage (from url: URL, completion: @escaping (UIImage?)->Void){
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            
            if let data = data {
                let image = UIImage(data: data)
                completion(image)
            } else {
                print(error as Any)
                completion(nil)
            }
            
        }.resume()
        
    }
    
    
}
