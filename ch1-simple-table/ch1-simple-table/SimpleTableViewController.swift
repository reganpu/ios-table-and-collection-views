//
//  SimpleTableViewController.swift
//  ch1-simple-table
//
//  Created by regan on 27/02/2017.
//  Copyright © 2017 Heng-Hao. All rights reserved.
//

import UIKit

// Conform the ViewController class to both the UITableViewDataSource & UITableViewDelegate 
// protocols
class SimpleTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Add in a declaration for the property
    // Create an empty array of a String type using initializer syntax
    var tableData = [String]()
    
    // MARK: Load view into memory (not display)
    // This function is executed as part of UIViewController's cycle
    // before the view is visible on-screen
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting up the data here will give the table the data it needs to draw itself
        // before it becomes visible
        for count in 0...10 {
            // The cell will contain the string "Item X"
            tableData.append("Item \(count)")
        }
        
        print("The tableData array contains \(tableData)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDataSource functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // the function is guaranteed to return a cell instance that you can work with, 
        // so you’re ready to configure its contents.
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        // MARK: Configuring the Cell
        // a UITableViewCell contains a UILabel outlet called textLabel
        // that you can set the text property of
        cell.textLabel!.text = tableData[indexPath.row]
        
        return cell
    }
    
    // MARK: UITableViewDelegate function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messageString = "You tapped row \(indexPath.row)"
        let alertController = UIAlertController(title: "Row Tapped", message: messageString, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: { print("\(messageString)") })
    }
    
}

