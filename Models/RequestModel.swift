//
//  RequestModel.swift
//  TokoShopping
//
//  Created by Ashutosh Lasod on 12/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import Foundation

struct RequestModel {
    var q: String = "samsung"
    var pmin: String = "0"
    var pmax: String = "100000"
    var wholesale: Bool = true
    var official: Bool = true
    var fShop: String = "2"
    var start: String = "0"
    var rows: String = "10"
}
