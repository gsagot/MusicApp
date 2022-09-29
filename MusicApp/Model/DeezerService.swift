//
//  DeezerService.swift
//  MusicApp
//
//  Created by Gilles Sagot on 22/09/2022.
//

import Foundation

// Singleton
class DeezerService {

    static var shared = DeezerService()
    
    private var session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
    private init () {}
    
    // Download JSON file with Deezer API 
    func getTrack (search: String, completionHandler: @escaping (Bool, SearchResult?)-> Void ) {
        
        let url = URL(string: "https://api.deezer.com/search/track/?q=\(search)&index=0&limit=60&output=json")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        task?.cancel()
        
        task = session.dataTask(with: request) { (data, response, error) in
           
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print ("ERROR: \(String(describing: error?.localizedDescription))")
                    completionHandler (false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print ("ERROR: \(String(describing: response))")
                    completionHandler (false, nil)
                    return
                }
                guard let result = try? JSONDecoder().decode(SearchResult.self, from: data) else {
                    print("JSON ERROR: \(String(describing: error?.localizedDescription))")
                    completionHandler (false, nil)
                    return
                }
                
                completionHandler (true, result)
            }
            
        }
        task?.resume()
        
    }
    
    
}

