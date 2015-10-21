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
    var yLoc:CGFloat        = 50
    var currentLocalAmount  = String()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        displayCurrencyViewElements()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        displayCurrencyViewElements()
    }
    
    func displayCurrencyViewElements(){
        
        // logo
        let logoWidth:CGFloat  = 191
        let logoHeight:CGFloat = 20
        let logoXPos           = (self.frame.size.width/2)-(logoWidth/2)
        
        let logoImageView   = UIImageView(image: UIImage(named: "assets/Logo.png"))
        logoImageView.frame = CGRect(x: logoXPos, y: yLoc, width: logoWidth, height: logoHeight)
        self.addSubview(logoImageView)
        
        let offset:CGFloat = 60 //20
        yLoc += logoHeight+offset
        
        // "AUD" label
        let labelWidth:CGFloat  = 150
        let labelHeight:CGFloat = 60
        let labelXPos           = (self.frame.size.width/2)-(labelWidth/2)
        
        let audLabel                = UILabel(frame: CGRect(x: labelXPos, y: yLoc, width: labelWidth, height: labelHeight))
        audLabel.textColor          = UIColor.whiteColor()
        audLabel.font               = UIFont(name: "HelveticaNeue-Medium", size: 60)
        audLabel.textAlignment      = NSTextAlignment.Center
        
        let audString = "aud"
        audLabel.text = audString.uppercaseString
        self.addSubview(audLabel)

        let labelOffset:CGFloat = 10
        yLoc += labelHeight+labelOffset
        
        // $$ textfield
        let defaultAmount   = "0.00" // set default amount to $0
        let amountWidth:CGFloat     = self.frame.size.width-105
        let amountHeight:CGFloat    = 80
        let amountXLoc              = (self.frame.size.width/2)-(amountWidth/2)
        
        let amountTextField             = UITextField(frame:CGRect(x: amountXLoc, y: yLoc, width: amountWidth, height: amountHeight))
        amountTextField.delegate        = self
        amountTextField.textColor       = audLabel.textColor
        amountTextField.font            = audLabel.font
        amountTextField.textAlignment   = audLabel.textAlignment
        amountTextField.keyboardType    = UIKeyboardType.DecimalPad
        amountTextField.text            = "$\(String(applyCurrencyStyleNumberFormat(defaultAmount)))"
        self.addSubview(amountTextField)
        
        // save this amount for later
        saveCurrentLocalAmount(amountTextField.text!)
        
        yLoc += amountHeight
        
        // add dashed border below the textfield
        addDashedBorderToTextField(amountTextField)
        
        // since it's the first instance of the view, apply the exchange rate
        applyExchangeRateToCurrentAmount(amountTextField.text!)
    }
    
    
    // MARK: UITextField Delegate Methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        // clear the textfield
        textField.text = ""
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        // save current input amount
        currentLocalAmount = textField.text!
        
        // set textfield with currency style
        applyCurrencyStyleNumberFormat(textField.text!)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
     
        applyExchangeRateToCurrentAmount(textField.text!)
        textField.text = "$\(String(applyCurrencyStyleNumberFormat(textField.text!)))"
        self.endEditing(true)
        
        return false
    }
    
    
    func saveCurrentLocalAmount(textFieldDefaultString:String){
        print(textFieldDefaultString)
        currentLocalAmount = textFieldDefaultString
    }
    
    func getCurrentLocalAmountAfterEdit() -> String{
        
        return self.currentLocalAmount
    }
    
    // MARK: Utilities
    
    func applyCurrencyStyleNumberFormat(stringToFormat:String) -> Double {
        
        let formatter           = NSNumberFormatter()
        formatter.numberStyle   = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale        = NSLocale(localeIdentifier: "en_US")
        let currencyNumber      = NSString(string: stringToFormat).doubleValue
        
        return currencyNumber
    }
    
    func applyExchangeRateToCurrentAmount(inputAmount:String){
        
        // remove all characters that aren't numbers for calculation
        let numbersOnlyString = inputAmount.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
        delegate?.calculateAmountUsingForeignRate(numbersOnlyString)
    }
    
    func addDashedBorderToTextField(textField:UITextField) {
        
        let color = UIColor.blackColor().CGColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = textField.bounds
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: 2)
        
        shapeLayer.bounds           = shapeRect
        shapeLayer.position         = CGPoint(x: frameSize.width/2, y: frameSize.height)
        shapeLayer.fillColor        = UIColor.clearColor().CGColor
        shapeLayer.strokeColor      = color
        shapeLayer.lineWidth        = 2
        shapeLayer.lineJoin         = kCALineJoinRound
        shapeLayer.lineDashPattern  = [5,6]
        shapeLayer.path             = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).CGPath
        
        textField.layer.addSublayer(shapeLayer)
    }
}