//
//  AddTodoViewController.swift
//  MVCExample
//
//  Created by Çağatay Emekci on 21.10.2018.
//  Copyright © 2018 Çağatay Emekci. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController {
    var todoModel: TodoModel?
    @IBOutlet weak var todoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addTodoButtonClick(_ sender: Any) {
        todoModel?.addTodo(todo: Todo(userId: 1, id: 1, title: todoTextField.text ?? "", completed: false))
        todoTextField.text = ""
    }
}
