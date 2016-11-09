//
//  Course.swift
//  MSSE652
//
//  Created by Mark Evans on 11/6/16.
//  Copyright © 2016 Mark Evans. All rights reserved.
//

import Foundation

class Course {
    var id: Int
    var name: String
    
    init() {
        id = 0
        name = ""
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func toString() -> String {
        return "Course: \(id) \(name)"
    }
}
