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
    var adManager: AdManager!
    var drinkStore: DrinkStore? {
        didSet {
            setUpCollectionView(drinkStore: drinkStore!)
        }
    }
    var smoothiesDataSource: SmoothiesCollectionViewDataSource?
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    //MARK:- view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
        showBannerAd()
    }
    
    //MARK:- View set up
    
    func setUpCollectionView(drinkStore: DrinkStore) {
        smoothiesDataSource = SmoothiesCollectionViewDataSource(drinkStore: drinkStore)
        smoothiesCollectionView.dataSource = smoothiesDataSource
        smoothiesCollectionView.delegate = self
        activityIndicator.stopAnimating()
    }
    
    func showBannerAd() {
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.toolbar.addSubview(adManager.adBannerView)
        adManager.loadBannerAd(rootViewController: self)
    }
    
    //MARK:- Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipes" {
            showRecipes(segue: segue)
        }
    }
    
    func showRecipes(segue: UIStoryboardSegue) {
        if let selectedIndexPath = smoothiesCollectionView.indexPathsForSelectedItems?.first {
            let smoothie = drinkStore?.allSmoothies[selectedIndexPath.row]
            let destinationVC = segue.destination as! SmoothieRecipesViewController
            destinationVC.drinkStore = drinkStore
            destinationVC.smoothie = smoothie
        }
    }
    
    //MARK:- CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showRecipes", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let smoothie = drinkStore?.allSmoothies[indexPath.row] {
            drinkStore?.fetchSmoothiePhoto(smoothie: smoothie, completion: { (result) in
                OperationQueue.main.addOperation({
                    if let photoIndex = self.drinkStore?.allSmoothies.index(of: smoothie) {
                        let photoIndexPath = NSIndexPath(row: photoIndex, section: 0)
                        if let cell = self.smoothiesCollectionView.cellForItem(at: photoIndexPath as IndexPath) as? SmoothiesCollectionViewCell {
                            cell.updateSpinnerWithImage(image: smoothie.image)
                            cell.updateSmoothieNameWithString(name: smoothie.label)
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
