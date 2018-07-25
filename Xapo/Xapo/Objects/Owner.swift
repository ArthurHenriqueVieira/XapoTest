//
//  Owner.swift
//  XapoTest
//
//  Created by Arthur Henrique Vieira de Oliveira on 24/07/18.
//  Copyright © 2018 Arthur Henrique Vieira de Oliveira. All rights reserved.
//

import Foundation

class Owner: Codable {
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case login = "login"
        case avatarUrl = "avatar_url"
    }
    
    var id: Int64!
    var login: String!
    var avatarUrl: String!
    
}
