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
        
        // TODO: set proper bg colour
        self.view.backgroundColor   = UIColor.blueColor()
        self.view.alpha             = 0.5
        
        collectionView?.dataSource = self
        collectionView?.delegate   = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: UICollectionViewDatasource Delegate Methods
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return foreignCurrencyArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.blackColor()
        
        // TODO: configure the cell
        
        return cell
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