//
//  ProductViewModel.swift
//  TokoShopping
//
//  Created by Ashutosh Lasod on 10/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import Foundation
import RxSwift

class ProductViewModel {
    
    var rowIndex : Int = 10
    
    typealias CollectionViewCellParameter = (imageUrl: String, productName: String, price: String)
    let productsObservable = BehaviorSubject<[CollectionViewCellParameter]>(value: [])
    let apiClient = NetworkingAPIClient()
    let disposeBag = DisposeBag()
    
    var products: [CollectionViewCellParameter] = []
    
    private static var instance: ProductViewModel? = nil
    static var sharedInstance: ProductViewModel {
        if instance == nil {
            instance = ProductViewModel()
        }
        
        return instance!
    }
    
    private init() {}
    
    func getInitialDataFromAPI(pMin: String = "0.0", pMax: String = "1000000.0", wholesale: Bool = true, official: Bool = true, fShop: String = "2", start: String = "0", rows: String = "10")
    {
        
        self.products.removeAll()
        var req = RequestModel()
        req.pmin = pMin
        req.pmax = pMax
        req.wholesale = wholesale
        req.official = official
        req.fShop = fShop
        req.start = start
        req.rows = "\(self.rowIndex)"
        
        apiClient.getProductList(request: req)
            .subscribe({ [unowned self] (response) in
                do {
                    let responseModel = try response.element?.response?.mapObject(ResponseModel.self)
                    let formattedView = responseModel?.data.map {
                        return (
                            imageUrl: $0.imageURI700,
                            productName: $0.name,
                            price: $0.price
                        )
                    }

                    if(formattedView != nil) {
                        self.productsObservable.onNext(formattedView!)
                    }
                } catch {
                    print("error")
                }

            })
            .disposed(by: disposeBag)
    }
}
