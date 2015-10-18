//
//  CashConverterDataController.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-19.
//  Copyright © 2015 Carla. All rights reserved.
//

import Foundation

typealias ModelCompletion = (models: [CurrencyValueModel]) -> (Void)

protocol CurrencyValueProviding {
    func getExternalCurrencyData(completion:ModelCompletion)
}

extension CurrencyValueProviding {
 
    func getExternalCurrencyData(completion:ModelCompletion){
        
        let url:NSURL!              = NSURL(string: "http://api.fixer.io/latest?base=AUD")
        let request:NSURLRequest    = NSURLRequest(URL: url)
        let config                  = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session                 = NSURLSession(configuration: config)
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            if error != nil {
                print("In the unlikely event that there is an error, handle it here. :)")
                return
            }
            
            guard let _ = data else {
                print("no data")
                return
            }
            
            print("No errors here. Carry on.")
            
            do {
                //TODO: off the main thread
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                
                // add only the supported currencies and their respective values to the model
                if let rates = json["rates"] as? [String: Double] {
                    let currencyModels = CurrencyValueModelFactory().currencyValueModels(rates)
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(models: currencyModels)
                    })
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(models: [])
                    })
                }
                
            } catch {
                print("error serializing JSON: \(error)")
                dispatch_async(dispatch_get_main_queue(), {
                    completion(models: [])
                })
            }
        })
        
        task.resume()
    }
}

struct CashConverterDataController: CurrencyValueProviding {
    
}