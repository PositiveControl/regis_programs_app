//
//  Program.swift
//  MSSE652
//
//  Created by Mark Evans on 10/27/16.
//  Copyright © 2016 Mark Evans. All rights reserved.
//

import Foundation

class Program {
    var id: Int
    var name: String
    
    init() {
        id = 0
        name = ""
    }
    
    func toString() -> String {
        return "\(id)\(name)"
    }
}
