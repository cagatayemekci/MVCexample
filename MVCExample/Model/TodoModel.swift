//
//  ToDoModel.swift
//  MVCExample
//
//  Created by Çağatay Emekci on 21.10.2018.
//  Copyright © 2018 Çağatay Emekci. All rights reserved.
//

import Foundation
import Alamofire

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
            .responseData { response in
                guard let data  = response.data else {return}
                let decoder = JSONDecoder()
                do {
                    self.todos = try decoder.decode([Todo].self, from:data )

                }catch let jsonError{
                    print("json parse error: \(jsonError)")
                }
                completion(true)
        }
    }
}
