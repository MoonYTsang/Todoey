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
//    let defautls = UserDefaults.standard  //Declare a standard UserDefaults. Note: UserDefaults is only suitable to store small piece of data like user preference, it is not good to store array or dictionaries which might expand to be very large amount data. One important thing is that the whole plist need to be reloaded to memroy before running the app, so even you only use a small bit of data in it, it need to wait until whole plist is loaded. So plist is not desired to be big. Also, it do not support custom type.
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") //append file name to the URL and return
    //Note: use appendingPathComponent() method, not appendPathComponent() method!!
    
    //MARK: - VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
//        if let items = defautls.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        } //get the value of the stored array
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

        saveItems()

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
                        self.itemArray.append(newItem)  //append new item to local array
                        
                        print("[Check] Item added to the list.")
                        self.saveItems()
                        
//                        self.defautls.set(self.itemArray, forKey: "TodoListArray") //save local array to UserDefaults
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
    
    //MARK: - MODEL MANUPULATION METHODS
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray) //encode array to a plist
            try data.write(to: dataFilePath!) //write the plist to the path
        } catch {
            print("Error encoding item array: \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            /* Use try when you want an error message back from the function that throws an error. Using try needs a do/catch clause.
             
             Use try? if you don't need an error message back from a function that throws an error.  Try? will send back a nil when an error occurs. With a try? statement, a do/catch clause is not needed. */
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data) //decode plist to array
                // what is .self?
                /* Basically, we need to pass the class 'type' as a value not an 'instance' of the class.
                
                We are telling it, use this blueprint to decode. Do not pass an object based on this blueprint, but the actual blueprint.
                
                You can use the postfix self expression to access a type as a value. For example, SomeClass.self returns SomeClass itself, not an instance of SomeClass.
                
                Click the link for Apple Docs on MetaTypes section:
 https://docs.swift.org/swift-book/ReferenceManual/Types.html#//apple_ref/swift/grammar/metatype-type */
 
            } catch {
                print("Error decoding item array: \(error)")
            }
        }
        
    }
    
}

