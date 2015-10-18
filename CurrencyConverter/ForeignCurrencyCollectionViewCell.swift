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
    
    lazy var currencyLabel: UILabel = {
        let label = UILabel(frame: self.bounds)
        
        label.textAlignment = NSTextAlignment.Center
        label.font          = UIFont(name: "HelveticaNeue-Medium", size: 40)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(currencyLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shouldDimText(shouldDim: Bool) {
        currencyLabel.textColor = shouldDim ? UIColor.grayColor() : UIColor.whiteColor()
    }

    func setCurrencyName(let currencyString:String){
        
        print("currency: \(currencyString)")
        currencyLabel.text = String(currencyString)
    }
}