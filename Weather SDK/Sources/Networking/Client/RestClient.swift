//
//  RestClient.swift
//  Weather SDK
//
//  Created by Lester Batres on 21/10/24.
//

import Combine
import Foundation

typealias JSON = [String: Any]

class RestClient {
    
    private let baseURL: String
    private let headers: HTTPHeaders
    private let sessionConfiguration: URLSessionConfiguration
    
    public init(configuration: ClientConfiguration) {
        baseURL = configuration.baseURL
        headers = configuration.httpHeaders
        sessionConfiguration = configuration.sessionConfiguration
    }
    
    public func request<T: Decodable, U :Decodable>(resource: Resource,
                                                    parameters: JSON? = nil,
                                                    headers: HTTPHeaders? = nil,
                                                    type: T.Type,
                                                    errorType: U.Type) -> AnyPublisher<T, Error> {
        let fullURLString = baseURL + resource.resource.route
        
        guard let url = URL(string: fullURLString) else {
            return Fail(error: NetworkingError.invalidRequestError("Invalid URL: \(fullURLString)")).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = resource.resource.method.rawValue
        
        headers?.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters {
            if resource.resource.method == .get {
                var urlComponents = URLComponents(string: fullURLString)
                
                let queryItems = parameters.compactMap { (key, value) -> URLQueryItem in
                    return URLQueryItem(name: key, value: value as? String)
                }
                
                urlComponents?.queryItems = queryItems
                
                urlRequest.url = urlComponents?.url
            } else {
                if let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) {
                    urlRequest.httpBody = data
                    debugPrint(url: fullURLString, jsonData: data, title: "Request JSON")
                }
            }
        }
        
        return URLSession(configuration: sessionConfiguration).dataTaskPublisher(for: urlRequest)
            .mapError({ error -> NetworkingError in
                if error.code == .notConnectedToInternet || error.code == .networkConnectionLost {
                    return .noInternetConnection
                }
                
                return .unexpectedError(error)
            })
            .tryMap({ [weak self] (data, response) -> (data: Data, response: URLResponse) in
                guard let urlResponse = response as? HTTPURLResponse else {
                    self?.debugPrint(url: fullURLString, jsonData: data, title: "Response JSON")
                    
                    throw NetworkingError.invalidResponse
                }
                
                switch urlResponse.statusCode {
                case 401:
                    self?.debugPrint(url: fullURLString, jsonData: data, title: "Response JSON")
                    throw NetworkingError.unauthorized
                case 400, 402...599:
                    let decoder = JSONDecoder()
                    let apiError: Decodable
                    
                    self?.debugPrint(url: fullURLString, jsonData: data, title: "Response JSON")
                    
                    do {
                        apiError = try decoder.decode(errorType, from: data)
                    } catch {
                        let message = "Failed parsing object: \(String(describing: T.self))"
                        
                        throw NetworkingError.parsingError(error, message)
                    }
                    
                    throw NetworkingError.apiError(urlResponse.statusCode, error: apiError)
                default:
                    break
                }
                
                return (data, response)
            })
            .map(\.data)
            .tryMap({ [weak self] data -> T in
                let decoder = JSONDecoder()
                
                self?.debugPrint(url: fullURLString, jsonData: data, title: "Response JSON")
                
                do {
                    return try decoder.decode(T.self, from: data)
                } catch {
                    let message = "Failed parsing object: \(String(describing: T.self))"
                    
                    throw NetworkingError.parsingError(error, message)
                }
            })
            .eraseToAnyPublisher()
    }
    
    private func debugPrint(url: String, jsonData: Data, title: String) {
        #if DEBUG
        guard let json = String(data: jsonData, encoding: .utf8) else { return }
        print("⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃")
        print("‣ URL : \(url)")
        print("‣ \(title) : \(json)")
        NSLog("⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃⁃")
        #endif
    }
}
