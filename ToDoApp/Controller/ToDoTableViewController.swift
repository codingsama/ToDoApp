//
//  ToDoTableViewController.swift
//  ToDoApp
//
//  Created by Josh on 22/06/2019.
//  Copyright © 2019 Josh. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    var itemArray = ["Acheter du Lait", "Changer la couche de Victoria", "Sortir la poubelle "]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none

    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        
        
        if selectedCell?.accessoryType == .checkmark {
            selectedCell?.accessoryType = .none
        } else {
            selectedCell?.accessoryType = .checkmark
        }
    
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - ADD NEW ITEMS
    
    @IBAction func addNewItemButton(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "Creer une nouvelle tache", message: "", preferredStyle: .alert)

        var textField = UITextField()
        
        let action = UIAlertAction(title: "Ajouter Tache", style: .default) { (action) in
            
        self.itemArray.append(textField.text!)
        self.tableView.reloadData()
        }
        
       
        alert.addTextField { (item) in
           textField = item
          
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
   
        //self.present(alert, animated: true, completion: nil)
       
    }
    
    
}

