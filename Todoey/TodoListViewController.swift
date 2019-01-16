//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Yuet Tsang on 14/1/2019.
//  Copyright © 2019 Yuet Tsang. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //MARK: - GLOBAL VARIABLES AND CONSTANTS
    
    var itemArray = [Item]()
    let defautls = UserDefaults.standard  //Declare a standard UserDefaults. Note: UserDefaults is only suitable to store small piece of data like user preference, it is not good to store array or dictionaries which might expand to be very large amount data. Also, it do not support class type.

    //MARK: - VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = Item()
        item1.title = "Find Mary"
        itemArray.append(item1)
        let item2 = Item()
        item2.title = "Buy apples"
        itemArray.append(item2)
        let item3 = Item()
        item3.title = "Pay bills"
        itemArray.append(item3)
        
        if let items = defautls.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        } //get the value of the stored array
    }

    //MARK: - TABLEVIEW DATASOURCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Tenary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }

    //MARK: - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemArray[indexPath.row]
        
        print("[Check] Row selected. Text = \(item.title)")

        item.done.toggle() // i.e. item.done = !item.done

        tableView.reloadData()

//        if tableView.cellForRow(at: indexPath)?.accessoryType.rawValue == 0 {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
        //there are 5 values for a cell's accessoryType:
        // 0 - none
        // 1 - disclosureIndicator
        // 2 - detailDisclosureButton
        // 3 - checkmark
        // 4 - detailButton
        
        //when a row is selected, it is being highlighted in grey color, use tableView.deselectRow method to deselect the row so that the highlight goes away
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //MARK: - ADD NEW IB ACTIONS AND OUTLETS
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
//        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)    //Create UIAlertController object

        let addItemAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("[Check] Add Item button pressed.")
            
            if let textFieldArray = alert.textFields {  //optional binding for optional array
                if let text = textFieldArray[0].text {  //optional binding for optinal string
                    if text != "" {
                        let newItem = Item()
                        newItem.title = text
                        self.itemArray.append(newItem)
                        self.tableView.reloadData()
                        print("[Check] Item added to the list.")
                        self.defautls.set(self.itemArray, forKey: "TodoListArray")
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

