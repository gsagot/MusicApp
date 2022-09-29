//
//  PreviewService.swift
//  MusicApp
//
//  Created by Gilles Sagot on 26/09/2022.
//

import Foundation



class PreviewService {
    
    static var shared = PreviewService()
    
    private var session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
    private init () {}
    
    func getAudioFile (_ adress:String, completionHandler: @escaping (Bool, URL?)-> Void ) {
        
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
