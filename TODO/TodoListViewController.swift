//
//  ViewController.swift
//  TODO
//
//  Created by Yuxin Tan on 2020/12/8.
//  Copyright © 2020 Yuxin Tan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray=["买AJ","买羽绒服","买黑芝麻糊糊"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text=itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField=UITextField()
        let alert=UIAlertController(title: "添加一个新的TODO项目", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "添加项目", style: .default){(action) in
            //print(textField.text!)
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder="创建一个新项目"
            textField=alertTextField
            //print(alertTextField.text!)
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    
}

