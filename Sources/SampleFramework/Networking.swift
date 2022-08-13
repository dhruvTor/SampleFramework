//
//  Networking.swift
//  SampleFramework
//
//  Created by Dhruv Jaiswal on 05/08/22.
//

import Foundation

protocol NetworkSession{

    func get(from url:URL,completionHandler:@escaping (Data?,Error?) -> Void)
    func post(with request:URLRequest,completionHandler:@escaping (Data?,Error?) -> Void)
}

extension URLSession:NetworkSession{
    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: request) { data, _, error in
            completionHandler(data,error)
        }
        task.resume()
    }
    
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { data, response, error in
            completionHandler(data, error)
        }
        task.resume()
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
            
            /// Making a post request to send Data
            /// - Parameters:
            ///   - url: to post data to
            ///   - body: the object you want to send
            ///   - completionHandler: returns data and error
            public func sendData<T:Codable>(to url:URL,body:T,completionHandler:@escaping (NetworkResult<Data>) -> Void){
                var request = URLRequest(url: url)
                do{
                    let httpBody = try JSONEncoder().encode(body)
                    request.httpBody = httpBody
                    request.httpMethod = "POST"
                    session.post(with: request) { data, error in
                        let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                        completionHandler(result)
                    }
                }
                catch let error{
                    return completionHandler(.failure(error))
                }
            }
        }
    }
    
    public enum NetworkResult<Value>{
        case success(Value)
        case failure(Error?)
    }
}



