//
//  APIHandler.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 08/02/21.
//

import Foundation

class APIHandler {

    func getDataFromAPI(completionHandler: @escaping (Fact) -> Void) {

        let path = "https://catfact.ninja/fact?max_length=240"
        
        if let url: URL = URL(string: path) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        let fact = try JSONDecoder().decode(Fact.self, from: data)
                        completionHandler(fact)
        
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
            
        }
    }
    
    
}
