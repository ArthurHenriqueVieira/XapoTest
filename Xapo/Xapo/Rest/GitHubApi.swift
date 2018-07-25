//
//  GitHubApi.swift
//  XapoTest
//
//  Created by Arthur Henrique Vieira de Oliveira on 24/07/18.
//  Copyright © 2018 Arthur Henrique Vieira de Oliveira. All rights reserved.
//

import Foundation

class GitHubApi: RestApi {
    private let testPath = "/search/repositories?q=pushed:{date}&sort=stars&order=desc"
    private let testMdPath = "/repos/:owner/:repo/readme"
    
    func getAll(success: @escaping ([Project]) -> Void,
                failure: @escaping (String) -> Void) -> Void {
        
        callApi(requestURL: baseUrl + testPath.replacingOccurrences(of: "{date}", with: Date().toString(dateFormat: "YYYY-MM-dd")),
                method: .get,
                parameters: nil,
                success: { response in
                    
                    if let object = self.decodeObject(Response.self, with: response) {
                        success(object.projects)
                    }
                    
        }) { error in
        }
    }
}
