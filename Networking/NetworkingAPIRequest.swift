//
//  NetworkingAPIRequest.swift
//  TokoShopping
//
//  Created by Ashutosh Lasod on 12/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import Foundation
import Moya

enum NetworkingAPI {
    case getProductList(request: RequestModel)
}

extension NetworkingAPI: TargetType {
    
    var baseURL: URL { return URL(string: "https://ace.tokopedia.com/search/v2.5")! }
    
    var path: String {
        switch self {
        case .getProductList(_):
            return "/product"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProductList(_):
            return .get
        }
    }
    
    var parameters: [String:Any]? {
        switch self {
        case .getProductList(let request):
            return [
                "q": request.q,
                "pmin": request.pmin,
                "pmax": request.pmax,
                "wholesale": request.wholesale,
                "official": request.official,
                "fshop": request.fShop,
                "start": request.start,
                "rows": request.rows
            ]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters!, encoding: URLEncoding.default)
    }
}
