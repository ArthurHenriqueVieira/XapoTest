//
//  Readme.swift
//  XapoTest
//
//  Created by Arthur Henrique Vieira de Oliveira on 24/07/18.
//  Copyright © 2018 Arthur Henrique Vieira de Oliveira. All rights reserved.
//

import Foundation

class Readme: Codable {
    
    enum CodingKeys: String, CodingKey
    {
        case downloadUrl = "download_url"
    }
    
    var downloadUrl: String!
}
