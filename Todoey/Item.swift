//
//  Item.swift
//  Todoey
//
//  Created by Yuet Tsang on 16/1/2019.
//  Copyright © 2019 Yuet Tsang. All rights reserved.
//

import Foundation

class Item: Codable { //conform to protocol that allow encode this custom object to, or decode from, plist or JSON files.
    var title : String = ""
    var done : Bool = false
}
