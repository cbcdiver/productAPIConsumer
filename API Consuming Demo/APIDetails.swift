//
//  APIDetails.swift
//  API Consuming Demo
//
//  Created by Chris Chadillon on 2017-03-26.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import Foundation

class APIDetails {
    static let baseURL = "http://localhost:8080/json/"
    
    static let apiCallCompletions:[APICalls:([String])->String] = [.allProducts:{(params) in "products/all"},
                                                                   .deleteAProduct:{(params) in "products/delete/\(params[0])"}]
    
    class func buildUrl(callType:APICalls, params:[String])->URL {
        return URL(string: baseURL+apiCallCompletions[callType]!(params))!
    }
}
