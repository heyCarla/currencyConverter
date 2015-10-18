//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-08.
//  Copyright © 2015 Carla. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDelegate {
    
    var currencyData = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TODO: set actual bg colour, for now use default fugly green
        self.view.backgroundColor = UIColor.greenColor()

        getExternalCurrencyData()
        setCashConverterViewLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCashConverterViewLayout(){
        
        let xLoc:CGFloat        = 0
        var yLoc:CGFloat        = xLoc
        let viewWidth:CGFloat   = self.view.frame.size.width
        let viewHeight:CGFloat  = self.view.frame.size.height/2
        
        // AUD currency view
        let audCurrenceyView = AUDCurrenceyView(frame: CGRect(x: xLoc, y: yLoc, width: viewWidth, height: viewHeight))
        self.view.addSubview(audCurrenceyView)
        
        yLoc += viewHeight
        
        // Foreign currency view
        let foreignCurrencyView = ForeignCurrencyView(frame: CGRect(x: xLoc, y: yLoc, width: viewWidth, height: viewHeight))
        self.view.addSubview(foreignCurrencyView)
    }

    
    // MARK: Fetch Fixer.io data
    
    func getExternalCurrencyData(){
        
        // TODO: make GET request
        let url:NSURL!              = NSURL(string: "http://api.fixer.io/latest")
        let request:NSURLRequest    = NSURLRequest(URL: url)
        let config                  = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session                 = NSURLSession(configuration: config)
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            if error != nil {
                print("there was an error!")
            
            } else {
                
                print("no error :)")
                
                var result = NSString(data: data!, encoding: NSASCIIStringEncoding)!
                //callback(result, nil)
            }

            
        });
        
        task.resume()
    }
    
    func saveCurrentCurrencyData(data:NSData){
        
    }
    
}

