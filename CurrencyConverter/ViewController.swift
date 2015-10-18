//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-08.
//  Copyright © 2015 Carla. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, AUDCurrencyViewDelegate {
    
    var currencyDict = [String: Double]()
    var foreignCurrencyView: ForeignCurrencyView!
    private let dataController = CashConverterDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TODO: set actual bg colour, for now use default fugly green
        self.view.backgroundColor = UIColor.greenColor()

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
        let audCurrenceyView        = AUDCurrenceyView(frame: CGRect(x: xLoc, y: yLoc, width: viewWidth, height: viewHeight))
        audCurrenceyView.delegate   = self
        self.view.addSubview(audCurrenceyView)
        
        yLoc += viewHeight
        
        // Foreign currency view
        foreignCurrencyView = ForeignCurrencyView(frame: CGRect(x: xLoc, y: yLoc, width: viewWidth, height: viewHeight))
        self.view.addSubview(foreignCurrencyView)
    }

    func currentSelectedForeignCurrency() ->Double{
        return foreignCurrencyView.selectedForeignCurrencyRate
    }

    
    // MARK: AUDCurrencyViewDelegate Methods
    
    func calculateAmountUsingForeignRate(localAmount:String) {
        
        // calculate rate in the selected currency and display the new amount in ForeignCurrencyView
        let currentAmount   = Double(localAmount)
        let convertedAmount = currentAmount! * currentSelectedForeignCurrency()
        print(convertedAmount)
        
        foreignCurrencyView.updateForeignCurrencyLabel(convertedAmount)
    }
}

