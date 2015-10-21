//
//  ForeignCurrencyCollectionViewController.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-15.
//  Copyright © 2015 Carla. All rights reserved.
//

import Foundation
import UIKit

protocol ForeignCurencyCollectionViewControllerDelegate: class {
    func handleFlyerSelectionFromIndexPath(index:Int)
}

class ForeignCurencyCollectionViewController: UICollectionViewController {
    
    weak var delegate:ForeignCurencyCollectionViewControllerDelegate?
    private var supportedCurrencies: [CurrencyValueModel]?
    private let reuseIdentifier = "CurrencyCell"
    private var selectedIndexPath: NSIndexPath?
    private var currentSelectedCurrency: String?

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.backgroundColor = UIColor(red: 62/255, green: 183/255, blue: 93/255, alpha: 1)
        displayCollectionViewElements()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateDimming()
    }
    
    func supportedForeignCurrencies(currencies: [CurrencyValueModel]?){
        
        supportedCurrencies = currencies
        self.collectionView!.reloadData()
        self.updateDimming()
    }
    
    func displayCollectionViewElements(){

        collectionView!.showsHorizontalScrollIndicator = false
        collectionView!.registerClass(ForeignCurrencyCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.resetInsetsForCenterPaging()
    }
    
    private func resetInsetsForCenterPaging() {
        var insets = self.collectionView!.contentInset
        let widthWithOffset = (self.view.frame.size.width - (self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width) * 0.5
        insets.left = widthWithOffset
        insets.right = widthWithOffset
        self.collectionView!.contentInset = insets
        self.collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    private func updateDimming() {
        
        let visibleIndexPaths = self.collectionView!.indexPathsForVisibleItems()
        
        for indexPath in visibleIndexPaths {
            let attributes = self.collectionView!.layoutAttributesForItemAtIndexPath(indexPath)
            let cellFrameInSuperview = self.collectionView!.convertRect(attributes!.frame, toView: self.collectionView!.superview!)
            let cell = self.collectionView!.cellForItemAtIndexPath(indexPath) as! ForeignCurrencyCollectionViewCell
            
            let cellIsCenter = CGRectContainsPoint(cellFrameInSuperview, self.view.center)
            if cellIsCenter {
                selectedIndexPath = indexPath
                delegate!.handleFlyerSelectionFromIndexPath(indexPath.item)
            }
            cell.shouldDimText(!cellIsCenter)
        }
    }
    
    
    // MARK: UICollectionViewDatasource Methods
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.collectionView!.visibleCells()
    
        self.updateDimming()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return supportedCurrencies?.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let currencyCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ForeignCurrencyCollectionViewCell
        
        let currencyModel = self.supportedCurrencies![indexPath.item]
        currencyCell.setCurrencyName(currencyModel.currencyCode)
        currencyCell.shouldDimText(selectedIndexPath != nil)
        
        if selectedIndexPath == nil {
            selectedIndexPath = indexPath
        }
        
        return currencyCell
    }
    
    
    // MARK: UICollectionViewDelegate Methods
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}

extension ForeignCurencyCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 130, height: self.view.frame.size.height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}