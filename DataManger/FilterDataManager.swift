//
//  FilterDataManager.swift
//  TokoShopping
//
//  Created by Ashutosh Lasod on 12/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import Foundation

struct FilterDataManager {
    
    static var minPrice: Double = 0.0
    static var maxPrice: Double = 10000000.0
    static var isWholesale: Bool = true
    
    static func resetToInitialValues() {
        minPrice = 0
        maxPrice = 10000000
        isWholesale = true
    }

}
