//
//  DeezerService.swift
//  MusicApp
//
//  Created by Gilles Sagot on 22/09/2022.
//

import Foundation


class DeezerService {
    
    static var shared = DeezerService()
    
    private var session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
    private init () {}
    
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
    
    func getSample (_ adress:String, completionHandler: @escaping (Bool, URL?)-> Void ) {
        
        var task: URLSessionDataTask?
        
        let session = URLSession(configuration: .default)
        
        let url = URL(string: adress)
        
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsDirectoryURL.appendingPathComponent(url!.lastPathComponent)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        
        task = session.dataTask(with: request) { (data, response, error) in
           
            DispatchQueue.main.async {
                
                URLSession.shared.downloadTask(with: url!) { location, response, error in
                            guard let location = location, error == nil else { return }
                            do {
                                try FileManager.default.moveItem(at: location, to: destinationUrl)
                                print("File moved to documents folder")
                                completionHandler(true, destinationUrl)
                            } catch {
                                completionHandler(true, destinationUrl)
                                print(error)
                            }
                        }.resume()
            }
            
        }
        task?.resume()
        
    }
    
    
    
    
}

