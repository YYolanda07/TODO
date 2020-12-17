//
//  ViewController.swift
//  TODO
//
//  Created by Yuxin Tan on 2020/12/8.
//  Copyright © 2020 Yuxin Tan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray=[ItemData]()
    let dataFilePath=FileManager.default.urls(for:.documentDirectory,in:.userDomainMask).first?.appendingPathComponent("Items.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text=itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField=UITextField()
        let alert=UIAlertController(title: "添加一个新的TODO项目", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "添加项目", style: .default){(action) in
            //print(textField.text!)
            let newItem=ItemData()
            newItem.title=textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
            self.tableView.reloadData()
        }
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder="创建一个新项目"
            textField=alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    func saveItems() {
        let encoder=PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        }catch{
            print("编码错误：\(error)")
        }
    }
    func loadItems() {
        if let data=try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray=try decoder.decode([ItemData].self, from: data)
            }catch{
                print("解码item错误")
            }
            
        }
    }
    
}

