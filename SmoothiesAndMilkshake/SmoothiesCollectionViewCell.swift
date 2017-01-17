//
//  SmoothiesCollectionViewCell.swift
//  SmoothiesAndMilkshake
//
//  Created by Chris Tseng on 17/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import UIKit

class SmoothiesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var smoothieImageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func updateSpinnerWithImage(image: UIImage?) {
        guard image != nil else {
            spinner.startAnimating()
            smoothieImageView.image = nil
            return
        }
        spinner.stopAnimating()
        smoothieImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateSpinnerWithImage(image: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        updateSpinnerWithImage(image: nil)
    }
}
