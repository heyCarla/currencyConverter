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
    
    var yLoc:CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        displayCurrencyViewElements()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayCurrencyViewElements(){
        
        let viewWidth = self.frame.size.width
        
        // border
        let viewBorder              = UIView(frame: CGRect(x: 0, y: yLoc, width: viewWidth, height: 2))
        viewBorder.backgroundColor  = UIColor.grayColor()
        viewBorder.alpha            = 0.5
        self.addSubview(viewBorder)
        
        yLoc += viewBorder.frame.size.height
        
        // TODO: foreign currency selection (UICollectionView?)
        let view = UIView(frame: CGRect(x: 0, y: yLoc, width: viewWidth, height: 80))
        view.backgroundColor = UIColor.blueColor()
        self.addSubview(view)
        
        /////////////
        
        // down arrow
        let arrowWidth:CGFloat  = 20
        let arrowHeight:CGFloat = 14
        let arrowXPos           = (self.frame.size.width/2)-(arrowWidth/2)

        let downArrowImageView  = UIImageView(image: UIImage(named: "assets/Indicator_1.png"))
        let downArrowYPos       = viewBorder.frame.origin.y-(arrowHeight/2.5)
        downArrowImageView.frame = CGRect(x: arrowXPos, y: downArrowYPos, width: arrowWidth, height: arrowHeight)
        self.addSubview(downArrowImageView)
        
        // up arrow
        let upArrowImageView  = UIImageView(image: UIImage(named: "assets/Indicator_2.png"))
        let upArrowYPos       = view.frame.size.height-(arrowHeight/2.5)
//        upArrowImageView.backgroundColor = UIColor.yellowColor()
        upArrowImageView.frame = CGRect(x: arrowXPos, y: upArrowYPos, width: arrowWidth, height: arrowHeight)
        self.addSubview(upArrowImageView)

        
        let offset:CGFloat = 30
        yLoc += view.frame.size.height+offset
        
        // converted foreign currency label
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
