//
//  NetworkManager.swift
//  PhotoGallery
//
//  Created by Александр Басов on 12/27/21.
//

import UIKit

class NetworkManager {
    
    init() { }

    static let shared = NetworkManager()
    
    let session = URLSession(configuration: .default)
    let urlSession = URLSession.shared
    
     func getDictionary( onSuccess: @escaping (Result) -> Void, onError: @escaping (String) -> Void) {
        let url = "http://dev.bgsoft.biz/task/credits.json"
                
        guard let urrl = URL(string: url) else {
            onError("Error building URL")
            return
        }

        let task = session.dataTask(with: urrl) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }

                do {
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(Result.self, from: data)
                        onSuccess(result)
                    } else {
                        onError("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
        
    func getPhoto(key: String, onSuccess: @escaping (UIImage?) -> Void, onError: @escaping (String) -> Void) {
        
        guard let url = URL(string: "http://dev.bgsoft.biz/task/\(key).jpg") else {
            onError("Error building URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                let image = UIImage(data: data)
                onSuccess(image)
                
                if response.statusCode == 200 {
                    let image = UIImage(data: data)
                    onSuccess(image)
                } else {
                    onError("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                }
            }
        }
        task.resume()
    }
}

