//
//  SmoothieRecipesViewController.swift
//  SmoothiesAndMilkshake
//
//  Created by Chris Tseng on 18/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import UIKit

class SmoothieRecipesViewController: UIViewController {

    @IBOutlet var smoothieImageView: UIImageView!
    @IBOutlet var smoothieRecipeLabel: UILabel!
    @IBOutlet var moreInformationButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    var drinkStore: DrinkStore?
    var smoothie: Smoothies? {
        didSet {
            navigationItem.title = smoothie?.label
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scrollView.addSubview(smoothieRecipeLabel)
        
        showSmoothieRecipe(smoothie: self.smoothie)
    }
    
    func showSmoothieRecipe(smoothie: Smoothies?) {
        
        if let smoothieInformation = smoothie {
            self.smoothieImageView.image = smoothieInformation.image
            var indredientString = ""
            if let recipeStringArray = smoothieInformation.ingredientLines {
                for recipe in recipeStringArray {
                    indredientString += recipe + ", "
                }
                self.smoothieRecipeLabel.text = indredientString
            }
        }
        
    }
    
}
