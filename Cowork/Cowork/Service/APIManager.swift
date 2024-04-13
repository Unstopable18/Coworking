//
//  APIManager.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case invalidData
    
        case decodingFailed
    
}
class APIManager{
    
    static let shared = APIManager()
    private init(){}
    
    
    func makeAPIRequest<T: Codable>(url: URL, method: String, headers: [String: String]?, parameters: [String: Any]?, completion: @escaping (Result<T, APIError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameters = parameters {
            if method == "GET" {
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
                urlComponents.queryItems = parameters.map { URLQueryItem(name: "\($0)", value: "\($1)") }
                request.url = urlComponents.url
            } else {
                request.httpBody = parameters.map { "\($0)=\($1)" }.joined(separator: "&").data(using: .utf8)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        
        task.resume()
    }
    
}



