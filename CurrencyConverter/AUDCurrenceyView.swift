//
//  AUDCurrenceyView.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-15.
//  Copyright © 2015 Carla. All rights reserved.
//

import Foundation
import UIKit

class AUDCurrenceyView: UIView, UITextFieldDelegate {
    
    var yLoc:CGFloat = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        displayCurrencyViewElements()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func get
    
    func displayCurrencyViewElements(){
        
        // logo
        let logoWidth:CGFloat  = 191
        let logoHeight:CGFloat = 20
        let logoXPos           = (self.frame.size.width/2)-(logoWidth/2)
        
        let logoImageView   = UIImageView(image: UIImage(named: "assets/Logo.png"))
        logoImageView.frame = CGRect(x: logoXPos, y: yLoc, width: logoWidth, height: logoHeight)
        self.addSubview(logoImageView)
        
        let offset:CGFloat = 20
        yLoc += logoHeight+offset
        
        // "AUD" label
        let labelWidth:CGFloat  = 100
        let labelHeight:CGFloat = 70
        let labelXPos           = (self.frame.size.width/2)-(labelWidth/2)
        
        let audLabel                = UILabel(frame: CGRect(x: labelXPos, y: yLoc, width: labelWidth, height: labelHeight))
        audLabel.textColor          = UIColor.whiteColor()
        audLabel.font               = UIFont(name: "HelveticaNeue-Medium", size: 45)
        audLabel.textAlignment      = NSTextAlignment.Center
        
        let audString = "aud"
        audLabel.text = audString.uppercaseString
        self.addSubview(audLabel)

        yLoc += labelHeight
        
        // $$ textfield
        let defaultAmount           = "1.00" // set default amount to $1
        let amountWidth:CGFloat     = self.frame.size.width-105
        let amountHeight:CGFloat    = 50
        let amountXLoc              = (self.frame.size.width/2)-(amountWidth/2)
        
        let amountTextField             = UITextField(frame:CGRect(x: amountXLoc, y: yLoc, width: amountWidth, height: amountHeight))
        amountTextField.delegate        = self
        amountTextField.backgroundColor = UIColor.greenColor()
        amountTextField.textColor       = audLabel.textColor
        amountTextField.font            = audLabel.font
        amountTextField.textAlignment   = audLabel.textAlignment
        
        // TODO: prepend "$" to total
        
        amountTextField.text            = String(defaultAmount) //"$ \(defaultAmount)"
//        amountTextField.becomeFirstResponder()
        self.addSubview(amountTextField)
        
        yLoc += amountHeight
        
        // TODO: need a black dashed line, for now it's solid!
        let path                            = UIBezierPath(rect: amountTextField.bounds)
        amountTextField.layer.masksToBounds = false
        amountTextField.layer.shadowColor = UIColor.blackColor().CGColor
        amountTextField.layer.shadowOffset  = CGSize(width: 0, height: 2)
        amountTextField.layer.shadowRadius  = 0
        amountTextField.layer.shadowOpacity = 1
        amountTextField.layer.shadowPath    = path.CGPath
    }
    
    
    // MARK: UITextField Delegate Methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
     
        applyExchangeRateToCurrentAmount(textField.text!)
        return true
    }
    
    
    // MARK: Utilities
    
    func applyExchangeRateToCurrentAmount(inputAmount:String){
        
        let currentAmount = Double(inputAmount)
        print(currentAmount)
        
        // TODO: get currently selected foreign currency
        // for now assume it is CAD
        let selectedForeignCurrency = "CAD"
        let selectedCurrencyRate    = 0.9381

        // calculate rate in the selected currency
        let convertedAmount = currentAmount! * selectedCurrencyRate
        print(convertedAmount)
        
        // TODO: update the total amount in ForeignCurrencyView
        
    }
}