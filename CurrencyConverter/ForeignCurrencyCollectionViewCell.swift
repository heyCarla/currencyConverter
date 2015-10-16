//
//  ForeignCurrencyCollectionViewCell.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-15.
//  Copyright © 2015 Carla. All rights reserved.
//

import Foundation
import UIKit

class ForeignCurrencyCollectionViewCell: UICollectionViewCell {

    func setCurrencyName(let currencyString:String){
        
        print("currency: \(currencyString)")
        
        let currencyLabel           = UILabel(frame: self.bounds)
        currencyLabel.textAlignment = NSTextAlignment.Center
        currencyLabel.text          = String(currencyString)
        self.addSubview(currencyLabel)
    }
    
    // TODO: get currency name and display
}