//
//  ResponseModel.swift
//  TokoShopping
//
//  Created by Ashutosh Lasod on 12/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import Foundation

class ResponseModel: Codable {
    let status: Status
    let data: [ProductModel]
    
    init(status: Status, data: [ProductModel]) {
        self.status = status
        self.data = data
    }
}

//MARK: Model From Product Details
class ProductModel: Codable {
    let name, imageURI700: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURI700 = "image_uri_700"
        case price
    }
    
    init(name: String, imageURI700: String, price: String) {
        self.name = name
        self.imageURI700 = imageURI700
        self.price = price
    }
}

//MARK: Model to show the Status of request
class Status: Codable {
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case message
    }
    
    init(errorCode: Int, message: String) {
        self.errorCode = errorCode
        self.message = message
    }
}
