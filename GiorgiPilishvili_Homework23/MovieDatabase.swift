//
//  MovieDatabase.swift
//  GiorgiPilishvili_Homework23
//
//  Created by GIORGI PILISSHVILI on 16.08.22.
//

import Foundation

class MovieDatabase {
    
    static let shared = MovieDatabase()
    static let APIKey = "44454b0c86bf1edf3f312b0bfb02d6f2"
        
    func getData<T: Codable>(urlString: String, completion: @escaping (T) -> Void) {
        
        let url = URL(string: urlString)
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("[MovieDatabase] - Wrong response.")
                return
            }

            guard (200...299).contains(response.statusCode) else {
                print("[MovieDatabase] - Wrong status code.")
                return
            }
            
            guard let data = data else { return }
                        
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(object)
                }
                
            } catch {
                print("[MovieDatabase] - Decoding error.")
            }
            
        }.resume()
        
    }
    
}
