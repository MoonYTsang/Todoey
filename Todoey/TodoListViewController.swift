//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Yuet Tsang on 14/1/2019.
//  Copyright © 2019 Yuet Tsang. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Mary", "Buy apples", "Pay bill"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - TABLEVIEW DATASOURCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }

    //MARK: - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("[Check] Row selected. Text = \(itemArray[indexPath.row])")
        
        if tableView.cellForRow(at: indexPath)?.accessoryType.rawValue == 0 {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        //there are 5 values for a cell's accessoryType:
        // 0 - none
        // 1 - disclosureIndicator
        // 2 - detailDisclosureButton
        // 3 - checkmark
        // 4 - detailButton
        
        //when a row is selected, it is being highlighted in grey color, use tableView.deselectRow method to deselect the row so that the highlight goes away
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
}

