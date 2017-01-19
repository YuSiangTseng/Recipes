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
        
        showSmoothieRecipe(smoothie: self.smoothie)
        moreInformationButton.addTarget(self, action: #selector(moreInformation), for: .touchUpInside)
    }
    
    func setUpBorderForCollectionView() {
        scrollView.layer.borderColor = UIColor(red: 90/255, green: 202/255, blue: 250/255, alpha: 1).cgColor
        scrollView.layer.borderWidth = 1.0
    }
    
    func showSmoothieRecipe(smoothie: Smoothies?) {
        
        if let smoothieInformation = smoothie {
            self.smoothieImageView.image = smoothieInformation.image
            var indredientString = ""
            if let recipeStringArray = smoothieInformation.ingredientLines {
                for i in 0 ..< recipeStringArray.count {
                    if i == recipeStringArray.count - 1 {
                        indredientString += recipeStringArray[i]
                    } else {
                         indredientString += recipeStringArray[i] + ", "
                    }
                }
                self.smoothieRecipeLabel.text = indredientString
            }
        }
        
    }
    
    @objc func moreInformation() {
        guard smoothie?.sourceURL != nil,
        let url = URL(string: (smoothie?.sourceURL)!) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
