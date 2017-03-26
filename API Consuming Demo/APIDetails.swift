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
    static let apiCallCompletions:[Int:([String])->String] = [0:{(params) in "products/all"},
                                                              1:{(params) in "products/delete/\(params[0])"}]
    
    class func buildUrl(theAPICallIndex: Int, params:[String])->URL {
        return URL(string: APIDetils.baseURL+APIDetils.apiCallCompletions[theAPICallIndex]!(params))!
    }
}
