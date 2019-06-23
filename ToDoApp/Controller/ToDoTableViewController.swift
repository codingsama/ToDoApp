//
//  ToDoTableViewController.swift
//  ToDoApp
//
//  Created by Josh on 22/06/2019.
//  Copyright © 2019 Josh. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController{

    var itemArray : [Item] = [Item]()
    let fileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("atest.plist")
 
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.separatorStyle = .none

    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
    
        cell.accessoryType = item.done ? .checkmark : .none
   
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        let item = itemArray[indexPath.row]
        
        itemArray[indexPath.row].done = !item.done
        
        saveData()

        selectedCell?.accessoryType = item.done ? .checkmark : .none

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - ADD NEW ITEMS
    
    @IBAction func addNewItemButton(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "Creer une nouvelle tache", message: "", preferredStyle: .alert)

        var textField = UITextField()
        let newItem = Item()
        
        let action = UIAlertAction(title: "Ajouter Tache", style: .default) { (action) in
         
        newItem.title = textField.text!
        newItem.done = false
        self.itemArray.append(newItem)
        self.saveData()
   
        }
        
       
        alert.addTextField { (item) in
           textField = item
          
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
   
        //self.present(alert, animated: true, completion: nil)
       
    }
    
    //MARK: - DATA MANIPULATION METHODS
    
    func saveData() {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: self.fileManager!)
            
        }catch {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    func loadData() {
        
        do{
        let data = try Data(contentsOf: self.fileManager!)
        
        let decoder = PropertyListDecoder()
        itemArray = try decoder.decode([Item].self, from: data)
            
        }catch{
            print(error )
        }
    }
}

