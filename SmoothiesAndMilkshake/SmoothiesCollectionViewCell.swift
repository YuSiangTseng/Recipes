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
    @IBOutlet var smoothieName: UILabel!
    
    func updateSpinnerWithImage(image: UIImage?) {
        guard image != nil else {
            spinner.startAnimating()
            smoothieImageView.image = nil
            return
        }
        spinner.stopAnimating()
        smoothieImageView.image = image
    }
    
    func updateSmoothieNameWithString(name: String?) {
        guard name != nil else {
            spinner.startAnimating()
            smoothieName.text = nil
            return
        }
        spinner.stopAnimating()
        smoothieName.text = name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpShadowForLabel()
        updateSpinnerWithImage(image: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        updateSpinnerWithImage(image: nil)
    }
    
    func setUpShadowForLabel() {
        smoothieName.layer.shadowColor = UIColor.gray.cgColor
        smoothieName.layer.shadowOpacity = 1
        smoothieName.layer.shadowOffset = CGSize.zero
        smoothieName.backgroundColor = UIColor(red: 90/255, green: 202/255, blue: 250/255, alpha: 0.4)
    }
}
