//
//  APIInteractions.swift
//  API Consuming Demo
//
//  Created by Chris Chadillon on 2017-03-26.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import Foundation

class APIInteractions {
    class func getAllData(theURL:URL, onCompletion: @escaping ([Product]!)->Void) {
        var request = URLRequest(url: theURL)
        request.httpMethod = "GET"
        let searchTask = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print("Error fetching products: \(error)")
                onCompletion(nil)
                return
            }
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                
                print(resultsDictionary!)
                
                guard let dataDictionary = resultsDictionary!["data"] as? [String:AnyObject] else { return }
                guard let productArray = dataDictionary["products"] as? [[String:AnyObject]] else { return }
               
                let products:[Product] = productArray.map { productDictionary in
                    let productNumber = productDictionary["number"]! as! Int
                    let productName = productDictionary["name"]! as! String
                    let productPrice = productDictionary["price"] as! Double
                    
                    return Product(number: productNumber, name: productName, price: productPrice)
                }
                
                onCompletion(products)
            } catch {
                print("Error parsing JSON: \(error)")
                onCompletion(nil)
                return
            }
        }
        searchTask.resume()
    }
    
    class func deleteAProduct(theURL:URL, onCompletion: @escaping ([String:Any]!)->Void) {
        var request = URLRequest(url: theURL)
        request.httpMethod = "DELETE"
        let searchTask = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print("Error Deleting Products: \(error)")
                onCompletion(nil)
                return
            }
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                onCompletion(resultsDictionary!)
            } catch {
                print("Error parsing JSON: \(error)")
                onCompletion(nil)
                return
            }
        }
        searchTask.resume()
    }

}
