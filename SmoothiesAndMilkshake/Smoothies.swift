//
//  Smoothies.swift
//  SmoothiesAndMilkshake
//
//  Created by Chris Tseng on 16/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import UIKit

struct Smoothies {
    let label: String?
    let sourceURL: String?
    let imageURL: String?
    let ingredientLines: [String]?
    let dietLabels: [String]?
    
    init(label: String, sourceURL: String, imageURL: String, ingredientLines: [String], dietLabels: [String]) {
        self.label = label
        self.sourceURL = sourceURL
        self.imageURL = imageURL
        self.ingredientLines = ingredientLines
        self.dietLabels = dietLabels
    }
    
}
