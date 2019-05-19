//
//  NetworkRequests.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void

class NetworkRequests {
    
    static var shared = NetworkRequests()
    private init() {}

    private func setQueryItems(with parameters: [String: String]) -> [URLQueryItem] {
        let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return queryItems
    }
    
    func get<T: Decodable>(baseUrl: String, urlString: String,
                           headers: [String: String] = [:],
                           urlParameter: String?,
                           queryParameters: [String: String]?,
                           completion: @escaping (_ request: URLRequest?, Result<T, ErrorObject>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseUrl
        urlComponents.path = urlString
        
        if let urlParameter = urlParameter {
            urlComponents.path += urlParameter
        }
        
        if let queryParameters = queryParameters {
            urlComponents.queryItems = setQueryItems(with: queryParameters)
        }
        
        print("Get url request", urlComponents.url?.absoluteURL.absoluteString ?? "Couldn't print url")
        
        guard let url = urlComponents.url?.absoluteURL else {
            completion(nil, .failure(.requestError(errorMessage:  ErrorMessages.urlError)))
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        //create completion handler
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(request, .failure(.requestError(errorMessage: error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                print("Unable to parse the response in given type \(T.self)")
                return completion(request, .failure(.responseError(errorMessage: ErrorMessages.genericError)))
            }
            if self.isSuccessCode(urlResponse) {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(request, .success(responseObject))
                    return
                }
            } else {
                if let errorObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    return completion(request, .failure(.error(errorObject)))
                }
            }
            //couldnt parse error or data
            completion(request, .failure(.responseError(errorMessage: ErrorMessages.genericError)))
        }

        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    func downloadImage(url: String, completion: @escaping (_ imageData: Data?, _ error: String?) -> Void) {
        
        guard let requestUrlString = URL(string: url) else {
            completion(nil, "Error occurred")
            return
        }
        let task = URLSession.shared.dataTask(with: requestUrlString) { (data, _, error) in
            
            guard error != nil else {
                completion(nil, "Error occurred")
                return
            }
            guard let data = data else {
                completion(nil, "Error occurred")
                return
            }
            completion(data, nil)
        }
        task.resume()
    }
    
    //helper functions
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
}

enum HttpMethodType: String {
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}

enum ErrorMessages {
    static let genericError = "Something went wrong. Please try again later"
    static let urlError = "Unable to create URL from given string"
}

enum ErrorObject: Error {
    case noInternet
    case responseError(errorMessage: String)
    case requestError(errorMessage: String)
    case error(_ error: Any)
}
