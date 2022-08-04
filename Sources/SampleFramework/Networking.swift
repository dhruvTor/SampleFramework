//
//  Networking.swift
//  SampleFramework
//
//  Created by Dhruv Jaiswal on 05/08/22.
//

import Foundation

extension SampleFramework {
    public class Networking{
        
        /// Responsible for handling all networking calls
        /// - Warning: Must create before any API call
        public class Manager{
            public init(){}
            
            private var session = URLSession.shared
            
            public func loadData(from url:URL,completionHandler:@escaping (NetworkResult<Data>) -> Void){
               let task = session.dataTask(with: url) { data, response, error in
                   let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                   completionHandler(result)
                }
                task.resume()
            }
        }
    }
    
    public enum NetworkResult<Value>{
        case success(Value)
        case failure(Error?)
    }
}
