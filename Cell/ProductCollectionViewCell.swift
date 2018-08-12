//
//  ProductCollectionViewCell.swift
//  TokoShopping
//
//  Created by Ashutosh Lasod on 09/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showLoader(true)
    }
    
    func showLoader(_ bool : Bool){
        if bool{
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
        }else{
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
}
