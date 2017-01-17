//
//  DrinkStore.swift
//  SmoothiesAndMilkshake
//
//  Created by Chris Tseng on 16/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import UIKit

enum ImageResult {
    case Success(UIImage)
    case Failure(Error)
}

enum PhotoError: Error {
    case ImageCreationError
}

class DrinkStore {
    
    private (set) var allSmoothies: [Smoothies]
    
    init(allSmoothies: [Smoothies]) {
        self.allSmoothies = allSmoothies
    }
    
    func fetchSmoothiePhoto(smoothie: Smoothies, completion: @escaping (ImageResult) -> Void) {
        
        guard let url = URL(string: smoothie.imageURL!) else {
            return
        }
        if let image = smoothie.image {
            completion(.Success(image))
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            OperationQueue.main.addOperation({
                let result = self.processImageWithData(data: data)
                if case let .Success(image) = result {
                    smoothie.image = image
                }
                completion(result)
            })
            }.resume()

    }
    
    private func processImageWithData(data: Data?) -> ImageResult {
        guard data != nil,
            let image = UIImage(data: data!) else {
                return .Failure(PhotoError.ImageCreationError)
        }
        
        return .Success(image)
    }


}
