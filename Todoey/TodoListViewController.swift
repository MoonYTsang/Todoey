//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Yuet Tsang on 14/1/2019.
//  Copyright © 2019 Yuet Tsang. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mary", "Buy apples", "Pay bill"]
    
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
    
    //MARKS: - ADD NEW IB ACTIONS/OUTLETS
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
//        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)    //Create UIAlertController object

        let addItemAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("[Check] Add Item button pressed.")
            
            if let textFieldArray = alert.textFields {  //optional binding for optional array
                if let text = textFieldArray[0].text {  //optional binding for optinal string
                    if text != "" {
                        self.itemArray.append(text)
                        self.tableView.reloadData()
                        print("[Check] Item added to the list.")
                    }
                }
            }
//            if textField.text != "" {
//                self.itemArray.append(textField.text!)
//                self.tableView.reloadData()
//            }

        }   //Create UIAlertAction object + handler

        let cancelItemAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create an item"
//            textField = alertTextField  //let local var textField reference to alertTextField which is in a narrow scope that not able to be used by the UIAlertAction.
        }   //Add UITextField to UIAlertController

        alert.addAction(addItemAction)  //Add UIAlertAction to UIAlertController
        alert.addAction(cancelItemAction)  //Add Cancel button to the alert
        
        present(alert, animated: true, completion: nil) //UIViewController to display the UIAlertController
        
    }
}

