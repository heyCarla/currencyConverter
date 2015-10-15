//
//  ForeignCurrencyView.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-15.
//  Copyright © 2015 Carla. All rights reserved.
//

import Foundation
import UIKit

class ForeignCurrencyView: UIView {
    
    var yLoc:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        displayCurrencyViewElements()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayCurrencyViewElements(){
        
        let viewWidth = self.frame.size.width
        
        // TODO: add down arrow
        
        // border
        let viewBorder = UIView(frame: CGRect(x: 0, y: yLoc, width: viewWidth, height: 2))
        viewBorder.backgroundColor = UIColor.grayColor()
        self.addSubview(viewBorder)
        
        yLoc += viewBorder.frame.size.height
        
        // TODO: add up arrow

        // TODO: foreign currency selection (UICollectionView?)
        let view = UIView(frame: CGRect(x: 0, y: yLoc, width: viewWidth, height: 80))
        view.backgroundColor = UIColor.blueColor()
        self.addSubview(view)
        
        let offset:CGFloat = 30
        yLoc += view.frame.size.height+offset
                
        // TODO: converted foreign currency label
        let convertedLabelWidth:CGFloat     = self.frame.size.width-100
        let convertedLabelHeight:CGFloat    = 70
        let labelXPos                       = (self.frame.size.width/2)-(convertedLabelWidth/2)
        
        let convertedCurrencyLabel              = UILabel(frame: CGRect(x: labelXPos, y: yLoc, width: convertedLabelWidth, height: convertedLabelHeight))
        convertedCurrencyLabel.textColor        = UIColor.whiteColor()
        convertedCurrencyLabel.font             = UIFont(name: "HelveticaNeue-Medium", size: 45)
        convertedCurrencyLabel.textAlignment    = NSTextAlignment.Center
        self.addSubview(convertedCurrencyLabel)
        
        // TODO: set dynamic text
        
        convertedCurrencyLabel.text = "$888888888"
    }

}
