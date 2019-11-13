//
//  TasksTableViewController.swift
//  TasksApp
//
//  Created by Iv on 13.11.2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController {

    var rootTask: Task?
    var backwardHandler: (()->Void)?

    @IBAction func addTask(_ sender: Any) {
        askNameAndAddTask()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if rootTask == nil {
            rootTask = root
        }
        self.title = rootTask?.name
        
        //let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTask))
        //self.navigationItem.rightBarButtonItem = addButton
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rootTask?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        // Configure the cell...
        if let tasks = self.rootTask?.subtasks {
            let task = tasks[indexPath.row]
            cell.textLabel?.text = task.name
            cell.detailTextLabel?.text = "Subtasks: \(task.count)"
        }
        return cell
    }
    
    private func askNameAndAddTask() {
        var userIdTextField: UITextField?
        // Declare alert message
        let dialogMessage = UIAlertController(title: "Add Task", message: "Please enter task name", preferredStyle: .alert)
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if let userInput = userIdTextField!.text {
                if let r = self.rootTask as? MyTask {
                    r.subtasks.append(MyTask(name: userInput))
                    self.tableView.reloadData()
                }
           }
        })
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        // Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        // Add input TextField to dialog message
        dialogMessage.addTextField { (textField) -> Void in
            userIdTextField = textField
            userIdTextField?.placeholder = "task name"
        }
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = self.rootTask?.subtasks[indexPath.row] {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "vcTasks") as? TasksTableViewController {
                controller.rootTask = task
                controller.backwardHandler = { self.tableView.reloadData() }
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if (parent == nil) {
            self.backwardHandler?()
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
