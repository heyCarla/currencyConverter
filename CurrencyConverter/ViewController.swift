//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-08.
//  Copyright © 2015 Carla. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, AUDCurrencyViewDelegate, ForeignCurrencyViewDelegate {
    
    var currencyDict    = [String: Double]()
    var audCurrenceyView: AUDCurrenceyView!
    var foreignCurrencyView: ForeignCurrencyView!
    private let dataController = CashConverterDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(red: 65/255, green: 200/255, blue: 98/255, alpha: 1)
        setCurrencyConverterViewLayout()
        
        dataController.getExternalCurrencyData { models in
            self.foreignCurrencyView.setSupportedForeignCurrencies(models)
        }
    }
    
    func setCurrencyConverterViewLayout(){
        
        let xLoc:CGFloat        = 0
        var yLoc:CGFloat        = xLoc
        let viewWidth:CGFloat   = self.view.frame.size.width
        let viewHeight:CGFloat  = self.view.frame.size.height/2
        
        // AUD currency view
        audCurrenceyView            = AUDCurrenceyView(frame: CGRect(x: xLoc, y: yLoc, width: viewWidth, height: viewHeight))
        audCurrenceyView.delegate   = self
        self.view.addSubview(audCurrenceyView)
        
        yLoc += viewHeight
        
        // Foreign currency view
        foreignCurrencyView             = ForeignCurrencyView(frame: CGRect(x: xLoc, y: yLoc, width: viewWidth, height: viewHeight))
        foreignCurrencyView.delegate    = self
        self.view.addSubview(foreignCurrencyView)
    }

    func currentSelectedForeignCurrency() ->Double{
        return foreignCurrencyView.selectedForeignCurrencyRate
    }

    
    // MARK: AUDCurrencyViewDelegate Methods
    
//    func savedLocalInputAmount(inputAmount: String) {
//        audCurrenceyView.getCurrentLocalAmount()
//    }
    
    func calculateAmountUsingForeignRate(localAmount:String) {
        
        // calculate rate in the selected currency and display the new amount in ForeignCurrencyView
        let currentAmount   = Double(localAmount)
        let convertedAmount = currentAmount! * currentSelectedForeignCurrency()
        print(convertedAmount)
        
        foreignCurrencyView.updateForeignCurrencyLabel(convertedAmount)
    }
    
    
    // MARK: ForeignCurrencyViewDelegate Methods
    
    func updateForeignCurrencyLabel(newAmount: Double) {
        
        let localAmount = audCurrenceyView.getCurrentLocalAmountAfterEdit()
        calculateAmountUsingForeignRate(localAmount)
    }
}

