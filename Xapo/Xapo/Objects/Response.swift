//
//  Response.swift
//  XapoTest
//
//  Created by Arthur Henrique Vieira de Oliveira on 24/07/18.
//  Copyright © 2018 Arthur Henrique Vieira de Oliveira. All rights reserved.
//

import Foundation

class Response: Codable {
    
    enum CodingKeys: String, CodingKey
    {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case projects = "items"
    }
    
    var totalCount: Int64!
    var incompleteResults: Bool!
    var projects: [Project]!
}
