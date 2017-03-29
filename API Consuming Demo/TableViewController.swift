//
//  TableViewController.swift
//  API Consuming Demo
//
//  Created by Chris Chadillon on 2017-03-26.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var theProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addAProduct(_ sender: UIBarButtonItem) {
        APIInteractions.addAProduct(number: 4321, name: "Nine", price: 99.99,
                                    theURL: APIDetails.buildUrl(callType: .addProduct, params: []),
                                    onCompletion: { (theResult: [String:Any]?) -> () in
                                        DispatchQueue.main.async(execute: { () -> Void in
                                            print(theResult!)
                                            self.tableView.reloadData()
                                        })
        })
    }
    
    @IBAction func loadTheJSON(_ sender: Any) {
        APIInteractions.getAllData(theURL: APIDetails.buildUrl(callType: .allProducts, params: []),
                                   onCompletion: { (theProducts: [Product]?) -> () in
                                    self.theProducts = theProducts!
                                    DispatchQueue.main.async(execute: { () -> Void in
                                        self.tableView.reloadData()
                                    })
        })
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return theProducts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheCell", for: indexPath)
        
        cell.textLabel?.text = self.theProducts[indexPath.row].name+" (\(self.theProducts[indexPath.row].number))"
        cell.detailTextLabel?.text = self.theProducts[indexPath.row].price.description
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let productNumber = self.theProducts[indexPath.row].number
            self.theProducts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            APIInteractions.deleteAProduct(theURL: APIDetails.buildUrl(callType: .deleteAProduct, params: [String(productNumber)]),
                                           onCompletion: { (theResult: [String:Any]?) -> () in
                                            DispatchQueue.main.async(execute: { () -> Void in
                                                print(theResult!)
                                                self.tableView.reloadData()
                                            })
            })
        }
        
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
