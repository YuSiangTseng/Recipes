//
//  SmoothiesAPI.swift
//  SmoothiesAndMilkshake
//
//  Created by Chris Tseng on 16/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import Foundation

enum SmoothiesResult {
    case Success([Smoothies])
    case Failure(Error)
}

enum SmoothiesAPIError: Error {
    case InvalidJSONData
}

struct SmoothiesAPI {
    
    let smoothiesURLString = "https://api.edamam.com/search?q=smoothies&app_id=c1f22483&app_key=945f948f7024a5bc7f1b053cbd21e477&from=0&to=100"
    let session = URLSession.shared
    
    func fetchSmoothies(completion: @escaping (SmoothiesResult) -> Void) {
        
        guard let url = URL(string: smoothiesURLString) else {
                return;
        }
        session.dataTask(with: url) { (data, response, error) in
            OperationQueue.main.addOperation({ 
                let result = self.smoothiesResultWithData(data: data)
                completion(result)
            })
        }.resume()
        
    }
    
    private func smoothiesResultWithData(data: Data?) -> SmoothiesResult {
        guard data != nil,
            let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject],
            let smoothiesArray = jsonObject?["hits"] as? [[String : AnyObject]] else {
                return .Failure(SmoothiesAPIError.InvalidJSONData)
        }
        var finalSmoothies = [Smoothies]()
        for smoothiesJSON in smoothiesArray {
            if let smoothie = smoothiesWithArray(json: smoothiesJSON) {
                finalSmoothies.append(smoothie)
            }
        }
        
        return .Success(finalSmoothies)
    }
    
    private func smoothiesWithArray(json: [String : AnyObject]) -> Smoothies? {
        
        guard let recipe = json["recipe"] as? [String : AnyObject],
            let label = recipe["label"] as? String,
            let sourceURL = recipe["url"] as? String,
            let imageURL = recipe["image"] as? String,
            let ingredientLines = recipe["ingredientLines"] as? [String],
            let dietLabels = recipe["dietLabels"] as? [String] else {
                return nil
        }
        if sourceURL == "http://www.myrecipes.com/recipe/fruity-breakfast-smoothie-197243/" {
            return nil
        }
        return Smoothies(label: label, sourceURL: sourceURL, imageURL: imageURL, ingredientLines: ingredientLines, dietLabels: dietLabels)

    }

}
