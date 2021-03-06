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
                print("Error fetching products: \(String(describing: error))")
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
                print("Error Deleting Products: \(String(describing: error))")
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
    
    class func addAProduct(number:Int, name:String, price:Double, theURL:URL, onCompletion: @escaping ([String:Any]!)->Void) {
        var request = URLRequest(url: theURL)
        request.httpMethod = "POST"
        
        request.httpBody = buildAddPostDataString(number: number, name: name, price: price).data(using: .utf8)
        
        let searchTask = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print("Error Adding Product: \(String(describing: error))")
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
    
    class func  restTheAPI(theURL:URL, onCompletion: @escaping ([String:Any]!)->Void) {
        var request = URLRequest(url: theURL)
        request.httpMethod = "GET"
        let searchTask = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print("Error fetching products: \(String(describing: error))")
                onCompletion(nil)
                return
            }
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                onCompletion(resultsDictionary)
            } catch {
                print("Error parsing JSON: \(error)")
                onCompletion(nil)
                return
            }
        }
        searchTask.resume()
    }


    class func buildAddPostDataString(number:Int, name:String, price:Double) -> String {
        return "name=\(name)&number=\(number)&price=\(price)"
    }

}
