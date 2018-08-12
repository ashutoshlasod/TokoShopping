//
//  ProductViewController.swift
//  TokoShopping
//
//  Created by Ashutosh Lasod on 08/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductViewController: UIViewController {

    @IBOutlet weak var productCollectionView: UICollectionView!
    let disposeBag = DisposeBag()
    let viewModel = ProductViewModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.viewModel.getInitialDataFromAPI()
        self.viewModel.productsObservable.bind(to: self.productCollectionView.rx.items) { collectionView, row, element in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.ID_PRODUCT_COLLECTIONVIEW_CELL_IDENTIFIER, for: indexPath) as! ProductCollectionViewCell
            cell.contentView.layer.borderWidth = 0.5
            cell.contentView.layer.borderColor = UIColor.gray.cgColor
            let thumbUrl = element.imageUrl
            DispatchQueue.global(qos: .background).async {
                if let urlObject = URL.init(string: thumbUrl){
                    do{
                        let data = try Data.init(contentsOf: urlObject)
                        if let resultImage = UIImage.init(data: data){
                            DispatchQueue.main.async {
                                cell.productImageView.image = resultImage
                                cell.showLoader(false)
                            }
                        }
                    } catch {
                        debugPrint(Constant.ERROR_DOWNLOADING_IMAGE)
                        DispatchQueue.main.async {
                            cell.productImageView.image = nil
                            cell.showLoader(false)
                        }
                    }
                }
            }
            
            cell.productName.text = element.productName
            cell.productPrice.text = element.price
            return cell
        }
        .disposed(by: disposeBag)
        
        self.productCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        self.productCollectionView.rx.didEndDragging
            .subscribe(onNext: { [unowned self] _ in
                if (self.productCollectionView.contentOffset.y >= (self.productCollectionView.contentSize.height - self.productCollectionView.frame.size.height)) {
                    //reach bottom
                    self.viewModel.rowIndex += 10
                    self.viewModel.getInitialDataFromAPI(pMin: "\(FilterDataManager.minPrice)", pMax: "\(FilterDataManager.maxPrice)", wholesale: FilterDataManager.isWholesale, rows: "\(self.viewModel.rowIndex)")
                }
            })
            .disposed(by: disposeBag)
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Constant.SCREEN_WIDTH/2)-5, height: 300.0)
    }
}

