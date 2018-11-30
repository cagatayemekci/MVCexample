//
//  ViewController.swift
//  MVCExample
//
//  Created by Çağatay Emekci on 21.10.2018.
//  Copyright © 2018 Çağatay Emekci. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
    lazy var todoModel = TodoModel()
    let cellReuseIdentifier = "cell"
    @IBOutlet weak var todosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todosTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        todosTableView.delegate = self
        todosTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.refleshUIView(notification:)), name: Notification.Name("AddedNewObj"), object: nil)
    }
    
    @objc func refleshUIView(notification: Notification) {
        todosTableView.reloadData()
    }
    
    @IBAction func addTodoFromServerButtonClick(_ sender: Any) {
        todoModel.synchronizationTodo { (added) in
            if(added){
                self.todosTableView.reloadData()
            }
        }
    }
    
    @IBAction func ShowAddTodoVC(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let addTodoVC = storyBoard.instantiateViewController(withIdentifier: "AddTodoViewController") as! AddTodoViewController
        addTodoVC.todoModel = todoModel
        self.navigationController?.pushViewController(addTodoVC, animated:true)
    }
    
    
}

extension TodoListViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoModel.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell =  tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.text = self.todoModel.todos[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
}
