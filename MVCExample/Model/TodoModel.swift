//
//  ToDoModel.swift
//  MVCExample
//
//  Created by Çağatay Emekci on 21.10.2018.
//  Copyright © 2018 Çağatay Emekci. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class TodoModel {
    var todos = [Todo]()
    
    func addTodo(todo:Todo) {
        todos.append(todo)
        NotificationCenter.default.post(name: Notification.Name("AddedNewObj"), object: nil)
    }
    
    func remove(index:Int) {
        todos.remove(at: index)
    }
    
    func synchronizationTodo(completion: @escaping (Bool)->()){
        getRequestAPICall { (added) in
            completion(added)
        }
    }
}

extension TodoModel {
    func getRequestAPICall(completion: @escaping (Bool)->())  {
        let todosEndpoint: String = "https://jsonplaceholder.typicode.com/todos/"
        Alamofire.request(todosEndpoint, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                let jsons = JSON(response.result.value!).arrayValue
                for json in jsons{
                    let todo = Todo(userId: json["userId"].intValue , id: json["id"].intValue , title: json["title"].stringValue , completed: json["completed"].boolValue )
                    self.addTodo(todo: todo)
                }
                completion(true)
        }
    }
}
