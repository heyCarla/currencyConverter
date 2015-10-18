//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-08.
//  Copyright © 2015 Carla. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDelegate, AUDCurrencyViewDelegate {
    
    var currencyDict = [:]
    var foreignCurrencyView:ForeignCurrencyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TODO: set actual bg colour, for now use default fugly green
        self.view.backgroundColor = UIColor.greenColor()

        getExternalCurrencyData()
        setCurrencyConverterViewLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        foreignCurrencyView.setSupportedForeignCurrencies(self.currencyDict)
    }

    func currentSelectedForeignCurrency() ->Double{
        return foreignCurrencyView.selectedForeignCurrencyRate
    }

    
    // MARK: Fetch Fixer.io data
    
    func getExternalCurrencyData(){
        
        let url:NSURL!              = NSURL(string: "http://api.fixer.io/latest?base=AUD")
        let request:NSURLRequest    = NSURLRequest(URL: url)
        let config                  = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session                 = NSURLSession(configuration: config)
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            if error != nil {
                print("In the unlikely event that there is an error, handle it here. :)")
            
            } else {
                
                print("No errors here. Carry on.")
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)

                    // add only the supported currencies and their respective values to currencyDict
                    let supportedCurrencies = ["CAD", "EUR", "GBP", "JPY", "USD"]
                    
                    if let rates = json["rates"] as? NSDictionary {
                        
                        let supportedCurrencyValues = supportedCurrencies.flatMap {
                            return rates[$0] as? Double
                        }
                        
                        //print(supportedCurrencyValues)
                        
                        var supportedCurrencyDict: [String: Double] = [:]
                        
                        for (key, value) in supportedCurrencies.enumerate() {
                            supportedCurrencyDict[value] = supportedCurrencyValues[key]
                        }
                        
                        self.currencyDict = supportedCurrencyDict
                        //print(self.currencyDict)
                    }

                } catch {
                    print("error serializing JSON: \(error)")
                }
            }
        });
        
        task.resume()
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

