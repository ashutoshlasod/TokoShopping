//
//  FiltersTableViewController.swift
//  TokoShopping
//
//  Created by Ashutosh Lasod on 12/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftRangeSlider

class FiltersTableViewController: UITableViewController {
    
    @IBOutlet weak var minPriceLabel: UILabel!
    @IBOutlet weak var maxPriceLabel: UILabel!
    @IBOutlet weak var priceRangeSlider: RangeSlider!
    @IBOutlet weak var wholeSaleBtn: UISwitch!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setupInitialDataFromDataManager()
        actionFromTableViewCellsSetup()
        setupSliderValueChangedAction()
    }
    
    func setupNavigationView() {
        let crossButton = UIBarButtonItem(image: #imageLiteral(resourceName: "cross"), style: .plain, target: self, action: #selector(dismissFilterVC))
        let resetButton = UIBarButtonItem(title: "RESET", style: .plain, target: self, action: #selector(resetButtonPressed))
        resetButton.tintColor = UIColor.appThemeColor
        crossButton.tintColor = UIColor.appThemeColor
        self.navigationItem.rightBarButtonItem = resetButton
        self.navigationItem.leftBarButtonItem = crossButton
    }
    
    //Action for Closing the Filter Menu
    @objc func dismissFilterVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Action for Reset Filters
    @objc func resetButtonPressed() {
        FilterDataManager.resetToInitialValues()
        self.setupInitialDataFromDataManager()
        self.updateSliderLabels()
    }

    //Setup Inital Data from data Manager
    func setupInitialDataFromDataManager() {
        self.wholeSaleBtn.isOn = FilterDataManager.isWholesale
        self.priceRangeSlider.lowerValue = FilterDataManager.minPrice
        self.priceRangeSlider.upperValue = FilterDataManager.maxPrice
    }
    
    //Updating Labels
    func updateSliderLabels() {
        self.minPriceLabel.text = "Rp. \(self.priceRangeSlider.lowerValue)"
        self.maxPriceLabel.text = "Rp. \(self.priceRangeSlider.upperValue)"
    }
    
    //Actions for Slider Values Change
    func setupSliderValueChangedAction() {
        self.updateSliderLabels()
        self.priceRangeSlider
            .rx
            .controlEvent(UIControlEvents.valueChanged)
            .subscribe(onNext: { [unowned self] in
                self.updateSliderLabels()
            })
            .disposed(by: disposeBag)
    }
    
    //Action Apply Button clicked to Save Filters
    func applyFilters() {
        FilterDataManager.minPrice = self.priceRangeSlider.lowerValue
        FilterDataManager.maxPrice = self.priceRangeSlider.upperValue
        FilterDataManager.isWholesale = self.wholeSaleBtn.isOn
    }

    func actionFromTableViewCellsSetup() {
        self.tableView
        .rx
        .itemSelected
        .subscribe(onNext: { [unowned self] indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
            if indexPath.section == 1 {
                self.applyFilters()
                ProductViewModel.sharedInstance.getInitialDataFromAPI(pMin: "\(FilterDataManager.minPrice)", pMax: "\(FilterDataManager.maxPrice)", wholesale: FilterDataManager.isWholesale)
                self.navigationController?.popViewController(animated: true)
            }
        })
        .disposed(by: disposeBag)
    }
    
}
