//
//  RestApi.swift
//  XapoTest
//
//  Created by Arthur Henrique Vieira de Oliveira on 24/07/18.
//  Copyright © 2018 Arthur Henrique Vieira de Oliveira. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class RestApi {
    
    internal let baseUrl = Bundle.main.infoDictionary!["Base Url"] as! String
    
    internal func callApi(requestURL:String,
                          method:HTTPMethod,
                          parameters:Dictionary<String, Any>?,
                          success: @escaping (String) -> Void,
                          failure: @escaping (String) -> Void) -> Void {
        
        if isConnectedToInternet() {
            
            print(requestURL)
            
            Alamofire.request(requestURL,
                              method: method,
                              parameters: parameters,
                              encoding: JSONEncoding.default).responseString { (response:DataResponse<String>) in
                                self.responseAction(response: response, success: success, failure: failure)
            }
        } else {
            failure("")
        }
    }
    
    internal func responseAction(response: DataResponse<String>,
                                 success: @escaping (String) -> Void,
                                 failure: @escaping (String) -> Void) -> Void {
        
        print(response)

        if let responseResponse = response.response {
            print(responseResponse)
        }
        
        if let r = response.response {
            if r.statusCode >= 200 && r.statusCode <= 299 {
                if let value = response.result.value {
                    success(value)
                }
                return
            } else {
            }
        }
    }
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    internal func getHeaders() -> HTTPHeaders {
        
        let headers: HTTPHeaders!
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        
        headers = ["App-Version" : appVersion,]
        
        return headers
    }
    
    internal func formatQuery(_ stringUrl: String, _ parameters: Dictionary<String, Any>) -> String {
        
        var output: String = ""
        
        for (key,value) in parameters {
            output += "\(key)=\(value)&"
        }
        
        output = String(output.dropLast())
        
        return stringUrl + "?" + output
    }
    
    internal func decodeObject<T>(_ type: T.Type, with response: String) -> T? where T : Decodable {
        
        
        do {
            let jsonData = response.data(using: .utf8)!
            let decoder = JSONDecoder()
            
            let product = try decoder.decode(T.self, from: jsonData)
            return product
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
}
