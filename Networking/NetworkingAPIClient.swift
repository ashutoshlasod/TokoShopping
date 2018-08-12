//
//  NetworkingAPIClient.swift
//  TokoShopping
//
//  Created by Ashutosh Lasod on 12/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class NetworkingAPIClient {
    
    private let provider = MoyaProvider<NetworkingAPI>()
    
    func getProductList(request: RequestModel) -> Observable<ProgressResponse> {
        return provider
            .rx.requestWithProgress(NetworkingAPI.getProductList(request: request))
    }
}
