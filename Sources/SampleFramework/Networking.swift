//
//  Networking.swift
//  SampleFramework
//
//  Created by Dhruv Jaiswal on 05/08/22.
//

import Foundation

protocol NetworkSession{

    func get(from url:URL,completionHandler:@escaping (Data?,Error?) -> Void)
}

extension URLSession:NetworkSession{
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        dataTask(with: url) { data, response, error in
            completionHandler(data, error)
        }.resume()
    }
    
    
}

extension SampleFramework {
    public class Networking{
        
        /// Responsible for handling all networking calls
        /// - Warning: Must create before any API call
        public class Manager{
            public init(){}
            
            internal var session:NetworkSession = URLSession.shared
            
            /// <#Description#>
            /// - Parameters:
            ///   - url: url to fetch data from
            ///   - completionHandler: returns data and error
            ///   Warning
            public func loadData(from url:URL,completionHandler:@escaping (NetworkResult<Data>) -> Void){
               session.get(from: url) { data, error in
                   let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                   completionHandler(result)
                }
            }
        }
    }
    
    public enum NetworkResult<Value>{
        case success(Value)
        case failure(Error?)
    }
}



