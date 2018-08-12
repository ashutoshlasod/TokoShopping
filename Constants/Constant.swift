//
//  Constant.swift
//  TokoShopping
//
//  Created by Ashutosh Lasod on 08/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import UIKit

class Constant: NSObject {
    
    //MARK: Screen size constants
    static let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.size.height
    static let IS_IPAD = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
    
    //MARK: ERROR Constants
    static let ERROR_DOWNLOADING_IMAGE = "Error downloading the image"
    
    //MARK: VC IDENTIFIERS
    static let ID_STORYBOARD = "Main"
    static let ID_FILTER_VC = "FiltersTableViewController"
    static let ID_SHOPTYPE_VC = "ShopTypeViewController"
    static let ID_PRODUCT_COLLECTIONVIEW_CELL_IDENTIFIER = "ProductCollectionViewCell"
    
}
