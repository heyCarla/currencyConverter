//
//  ForeignCurrencyCollectionViewController.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-15.
//  Copyright © 2015 Carla. All rights reserved.
//

import Foundation
import UIKit

class ForeignCurencyCollectionViewController: UICollectionViewController {
    
    let foreignCurrencyArray    = ["CAD", "EUR", "GBP", "JPY", "USD"]
    private let reuseIdentifier = "CurrencyCell"
    private let sectionInsets   = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        
//        // TODO: set proper bg colour
//        self.view.backgroundColor   = UIColor.blueColor()
//        self.view.alpha             = 0.5
//        
//        setCollectionViewSpecs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCollectionViewSpecs(){
        
        collectionView!.contentSize                     = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        collectionView!.scrollEnabled                   = true
        collectionView!.showsHorizontalScrollIndicator  = false
        collectionView!.delegate                        = self
        collectionView!.dataSource                      = self
        collectionView!.registerClass(ForeignCurrencyCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        collectionView!.frame                           = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80)
        collectionView!.reloadData()
    }
    
    
    // MARK: UICollectionViewDatasource Methods
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3//foreignCurrencyArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let currencyCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ForeignCurrencyCollectionViewCell
        
        // TODO: configure the cell
        
        let stringName = foreignCurrencyArray[indexPath.item]
        currencyCell.setCurrencyName(stringName)
        
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
            return CGSize(width: 100, height: 100)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
}