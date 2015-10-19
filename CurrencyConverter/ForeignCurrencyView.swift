//
//  ForeignCurrencyView.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-15.
//  Copyright © 2015 Carla. All rights reserved.
//

import Foundation
import UIKit

//protocol ForeignCurrencyViewDelegate {
//    func updateForeignCurrencyLabel(newAmount:Double)
//}

class ForeignCurrencyView: UIView, ForeignCurencyCollectionViewControllerDelegate {
    
//    var delegate:ForeignCurrencyViewDelegate?
    var updatedAmount:Double        = 0.0
    var yLoc:CGFloat                = 20
    var supportedCurrencies:  [CurrencyValueModel]? {
        didSet {
            // set default currency/rate
            currencyCollectionViewController.supportedForeignCurrencies(supportedCurrencies)
        }
    }
    var selectedForeignCurrencyRate = Double()
    var selectedForeignCurrencyName = String()
    var convertedCurrencyLabel      = UILabel()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout                  = CenterPagingFlowLayout()
        flowLayout.scrollDirection      = .Horizontal
        flowLayout.minimumLineSpacing   = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSizeMake(100, 80)
        return flowLayout
    }()
    
    lazy var currencyCollectionViewController: ForeignCurencyCollectionViewController = {
        return ForeignCurencyCollectionViewController(collectionViewLayout: self.flowLayout)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        displayCurrencyViewElements()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSupportedForeignCurrencies(currencies: [CurrencyValueModel]){
        //print(currencyDict)
        supportedCurrencies = currencies
    }
    
    func displayCurrencyViewElements(){
        
        let viewWidth = self.frame.size.width
        
        // border
        let viewBorder              = UIView(frame: CGRect(x: 0, y: yLoc, width: viewWidth, height: 2))
        viewBorder.backgroundColor  = UIColor.grayColor()
        viewBorder.alpha            = 0.5
        self.addSubview(viewBorder)
        
        yLoc += viewBorder.frame.size.height
        
        // foreign currency selection via UICollectionView
        createCollectionView()
        
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
        let upArrowYPos       = yLoc-(arrowHeight/2.5)
        upArrowImageView.frame = CGRect(x: arrowXPos, y: upArrowYPos, width: arrowWidth, height: arrowHeight)
        self.addSubview(upArrowImageView)
        
        let offset:CGFloat = 30
        yLoc += offset
        
        // converted foreign currency label
        let convertedLabelWidth:CGFloat     = self.frame.size.width-100
        let convertedLabelHeight:CGFloat    = 70
        let labelXPos                       = (self.frame.size.width/2)-(convertedLabelWidth/2)
        
        convertedCurrencyLabel                  = UILabel(frame: CGRect(x: labelXPos, y: yLoc, width: convertedLabelWidth, height: convertedLabelHeight))
        convertedCurrencyLabel.textColor        = UIColor.whiteColor()
        convertedCurrencyLabel.font             = UIFont(name: "HelveticaNeue-Medium", size: 45)
        convertedCurrencyLabel.textAlignment    = NSTextAlignment.Center
        self.addSubview(convertedCurrencyLabel)
        
        convertedCurrencyLabel.text = "$ \(updatedAmount)"
    }
    
    func createCollectionView(){

        currencyCollectionViewController.view.frame = CGRect(x: 0, y: yLoc, width: self.frame.size.width, height: 80)
        currencyCollectionViewController.delegate   = self
        self.addSubview(currencyCollectionViewController.view)
        
        yLoc += currencyCollectionViewController.view.frame.size.height
    }
    
    func updateForeignCurrencyLabel(updatedAmount:Double){
        
        // check for foreign currency $ symbols and append
        var currencySymbol = "$" // use dollar sign as default
        
        switch selectedForeignCurrencyName {
        case "EUR":
            currencySymbol = "€"
        case "GBP":
            currencySymbol = "£"
        case "JPY":
            currencySymbol = "¥"
        default:
            currencySymbol = "$"
        }
        
        convertedCurrencyLabel.text = "\(currencySymbol)\(updatedAmount)"
    }
    
    
    // MARK: ForeignCurencyCollectionViewControllerDelegate Methods

    func handleFlyerSelectionFromIndexPath(index:Int){

        //print("cell path: \(index)")
        
        // set currency/rate to use in conversion
        let currencyModel           = self.supportedCurrencies![index]
        selectedForeignCurrencyRate = currencyModel.currentValue
        selectedForeignCurrencyName = currencyModel.currencyCode
    }
}
