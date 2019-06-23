//
//  ToDoTableViewController.swift
//  ToDoApp
//
//  Created by Josh on 22/06/2019.
//  Copyright © 2019 Josh. All rights reserved.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController {

    var itemArray : [Item] = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.separatorStyle = .none
        
         print("File path \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)")
        

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
    
    //MARK: - TableView Interaction Methods
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
        
        
        let action = UIAlertAction(title: "Ajouter Tache", style: .default) { (action) in
        
        let newItem = Item(context: self.context)
            
        newItem.title = textField.text!
        //newItem.done = false
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
     
        
        do{
            try context.save()
            
        }catch {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    func loadData() {
        
        do{
            let request : NSFetchRequest<Item> = Item.fetchRequest()
            
            itemArray = try context.fetch(request)
            
        }catch {
                print(error)
        }
 
    }
}

