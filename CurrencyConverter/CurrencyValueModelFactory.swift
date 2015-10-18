//
//  CurrencyValueModelFactory.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-19.
//  Copyright © 2015 Carla. All rights reserved.
//

import Foundation

let supportedCurrencies = ["CAD", "EUR", "GBP", "JPY", "USD"]

protocol CurrencyValueModelProviding {
    func currencyValueModels(dict:[String:Double]) ->[CurrencyValueModel]
}

extension CurrencyValueModelProviding {
    
    func currencyValueModels(dict:[String:Double]) ->[CurrencyValueModel] {
        
        let supportedCurrencyValues: [CurrencyValueModel] = supportedCurrencies.flatMap { currency in
            if let currencyValue = dict[currency] {
                return CurrencyValueModel(currencyCode: currency, currentValue: currencyValue)
            }
            
            return nil
        }
        
        return supportedCurrencyValues
    }
}

struct CurrencyValueModelFactory: CurrencyValueModelProviding {
    
}