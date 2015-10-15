//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-08.
//  Copyright © 2015 Carla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TODO: set actual bg colour, for now use default fugly green
        self.view.backgroundColor = UIColor.greenColor()

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
        foreignCurrencyView.backgroundColor = UIColor.blueColor()
        self.view.addSubview(foreignCurrencyView)
    }
}

