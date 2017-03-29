//
//  APICalls.swift
//  API Consuming Demo
//
//  Created by Chris Chadillon on 2017-03-26.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import Foundation

enum APICalls: Int {
    case allProducts = 0
    case deleteAProduct = 1
    
    var theIndex:Int {
        get {
            return self.rawValue
        }
    }
}
