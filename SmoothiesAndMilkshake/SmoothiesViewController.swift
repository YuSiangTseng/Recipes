//
//  SmoothiesViewController.swift
//  SmoothiesAndMilkshake
//
//  Created by Chris Tseng on 16/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import UIKit

class SmoothiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet var smoothiesCollectionView: UICollectionView!
    var drinkStore: DrinkStore? {
        didSet {
            setUpCollectionView(drinkStore: drinkStore!)
        }
    }
    var smoothiesDataSource: SmoothiesCollectionViewDataSource?

    
    func setUpCollectionView(drinkStore: DrinkStore) {
        smoothiesDataSource = SmoothiesCollectionViewDataSource(drinkStore: drinkStore)
        smoothiesCollectionView.dataSource = smoothiesDataSource
        smoothiesCollectionView.delegate = self
    }
    
    //MARK:- Delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let smoothie = drinkStore?.allSmoothies[indexPath.row] {
            drinkStore?.fetchSmoothiePhoto(smoothie: smoothie, completion: { (result) in
                OperationQueue.main.addOperation({
                    if let photoIndex = self.drinkStore?.allSmoothies.index(of: smoothie) {
                        let photoIndexPath = NSIndexPath(row: photoIndex, section: 0)
                        if let cell = self.smoothiesCollectionView.cellForItem(at: photoIndexPath as IndexPath) as? SmoothiesCollectionViewCell {
                        cell.updateSpinnerWithImage(image: smoothie.image)
                        }
                    }
                    
                })
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width / 2.0) - 3.0
        let cellSize = CGSize(width: width, height: width)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
}
