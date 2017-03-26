//
//  APIDetails.swift
//  API Consuming Demo
//
//  Created by Chris Chadillon on 2017-03-26.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import Foundation

class APIDetils {
    static let baseURL = "http://localhost:8080/json/"
    static let apiCallCompletions = ["products/all"]
    
    class func buildUrl(theAPICallIndex: Int)->URL {
        return URL(string: APIDetils.baseURL+APIDetils.apiCallCompletions[theAPICallIndex])!
    }
}
