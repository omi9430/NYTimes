//
//  ApiManager.swift
//  Newyorktimes
//
//  Created by omair khan on 21/11/2021.
//

import Foundation


final class ApiManager {
    
    static let shared = ApiManager()
    
    struct ApiConstants {
        static let baseUrl =  "https://api.nytimes.com/svc/topstories/v2/home.json?api-key="
        static let apiKey =  "wZ6nNutGYhiI7LDJQUCTva0k88twlGep"
    }
    
    
    
    func getTopStories(completion: @escaping(Result<[Results], Error>) -> Void){
        
        guard let url = URL(string:ApiConstants.baseUrl + ApiConstants.apiKey) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let  task  = URLSession.shared.dataTask(with: request) { Data, _, error in
            
            
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let data = Data {
                    print(data)
                do {
                    
                    
                    let decoder = JSONDecoder()
                    // Create date decoding strategy
                    decoder.dateDecodingStrategy = .iso8601
                    //Decode json data
                    let task = try decoder.decode(TopStoriesResponse.self, from: data)
                    print(task.results[0].published_date)
                    completion(.success(task.results))
                    print(task.results.count)
                }catch {
                    completion(.failure(error))
                }
            }
            
        }
        task.resume()
    }
    
    
}
        
