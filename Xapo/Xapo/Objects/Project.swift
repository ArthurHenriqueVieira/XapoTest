//
//  Project.swift
//  XapoTest
//
//  Created by Arthur Henrique Vieira de Oliveira on 24/07/18.
//  Copyright © 2018 Arthur Henrique Vieira de Oliveira. All rights reserved.
//

import Foundation

class Project: Codable {
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case owner = "owner"
        case description = "description"
        case watchers = "watchers"
        case forks = "forks"
    }
    
    var id: Int64!
    var name: String!
    var fullName: String!
    var owner: Owner!
    var description: String!
    var watchers: Int64!
    var forks: Int64!
}
