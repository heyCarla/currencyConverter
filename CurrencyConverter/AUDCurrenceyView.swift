//
//  AUDCurrenceyView.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-15.
//  Copyright © 2015 Carla. All rights reserved.
//

import Foundation
import UIKit

protocol AUDCurrencyViewDelegate: class {
    func calculateAmountUsingForeignRate(localAmount:String)
}

final class AUDCurrenceyView: UIView, UITextFieldDelegate {
    
    weak var delegate:AUDCurrencyViewDelegate?
    var yLoc:CGFloat            = 50
    var updatedForeignAmount    = 0.0
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        displayCurrencyViewElements()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        amountTextField.keyboardType    = UIKeyboardType.DecimalPad
        
        amountTextField.text            = "$ \(defaultAmount)"
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
        
        // clear the textfield
        textField.text = ""
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        // set textfield with currency style
        let formatter           = NSNumberFormatter()
        formatter.numberStyle   = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale        = NSLocale(localeIdentifier: "en_US")
        let numberFromTextfield = NSString(string: textField.text!).doubleValue
        
        textField.text = formatter.stringFromNumber(numberFromTextfield)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
     
        // remove all characters that aren't numbers for calculation
        let numbersOnlyString = textField.text!.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
        delegate?.calculateAmountUsingForeignRate(numbersOnlyString)
        
        self.endEditing(true)
        
        return false
    }
    
    
    // MARK: Utilities
    
    func applyExchangeRateToCurrentAmount(inputAmount:String){
        
        let currentAmount = Double(inputAmount)
        print(currentAmount)
    }
}