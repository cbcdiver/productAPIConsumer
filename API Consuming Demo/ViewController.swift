//
//  ViewController.swift
//  API Consuming Demo
//
//  Created by Chris Chadillon on 2017-03-26.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var theProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIInteractions.getAllData(theURL: APIDetils.buildUrl(theAPICallIndex: APICalls.allProducts.theIndex),
                                   onCompletion: { (theProducts: [Product]?) -> () in
                                    self.theProducts = theProducts!
                                    DispatchQueue.main.async(execute: { () -> Void in
                                        print("Count = \(self.theProducts.count)")
                                    })
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

