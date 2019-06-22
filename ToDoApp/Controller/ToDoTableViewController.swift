//
//  ToDoTableViewController.swift
//  ToDoApp
//
//  Created by Josh on 22/06/2019.
//  Copyright © 2019 Josh. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    let itemArray = ["Acheter du Lait", "Changer la couche de Victoria", "Sortir la poubelle "]
    
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
    UIAlertAction.
    }
    
    
}

