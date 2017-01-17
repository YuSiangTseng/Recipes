//
//  SmoothiesCollectionViewDataSource.swift
//  SmoothiesAndMilkshake
//
//  Created by Chris Tseng on 17/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import UIKit

class SmoothiesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var drinkStore: DrinkStore
    
    init(drinkStore: DrinkStore) {
        self.drinkStore = drinkStore
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return drinkStore.allSmoothies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) as! SmoothiesCollectionViewCell
        cell.updateSpinnerWithImage(image: nil)
        
        return cell
    }
}
