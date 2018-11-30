//
//  Todo.swift
//  MVCExample
//
//  Created by Çağatay Emekci on 21.10.2018.
//  Copyright © 2018 Çağatay Emekci. All rights reserved.
//

import Foundation
import Alamofire
struct Todo : Hashable,Decodable {
    var userId:Int
    var id:Int
    var title:String
    var completed:Bool
    init(userId:Int,id:Int,title:String,completed:Bool) {
        self.userId = userId
        self.id = id
        self.title = title
        self.completed = completed
    }
    static func ==(lhs: Todo, rhs: Todo) -> Bool {
        return lhs.id == rhs.id
    }
    var hashValue: Int {
        return id.hashValue
    }
}

