//
//  APIClient.swift
//  LivelikeSample
//
//  Created by Shahid Ali on 4/11/21.
//

import UIKit

public typealias JSON = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum RequestMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}

class APIClient {
	
	//MARK:sendRequest
	private func sendRequest(_ path: String,
								 method: RequestMethod,
								 headers: HTTPHeaders? = nil,
								 queryItems : [URLQueryItem]? = nil,
								 body: JSON? = nil,
								 completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
		
			guard let url=createURLWithComponents(path:path, queryitems:queryItems)
			else {return nil}
			
			var urlRequest = URLRequest(url: url)
				urlRequest.httpMethod = method.rawValue

			if let headers = headers {
				urlRequest.allHTTPHeaderFields = headers
			}
			urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

			if let body = body {
				urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
			}

			let session = URLSession(configuration: .default)
			let task = session.dataTask(with: urlRequest) { data, response, error in
				completionHandler(data, response, error)
			}
			task.resume()
			return task
		}
	
	
	
	//MARK:sendRequest it accept generic type for data
	public func sendRequest<T: Decodable>(for: T.Type = T.self,
										  url : URLs,
										  method : RequestMethod,
										  headers : HTTPHeaders? = nil,
										  queryItems : [URLQueryItem]? = nil,
										  body : JSON? = nil,
										  completion : @escaping (Result<T,Error>) -> Void)
										  -> URLSessionDataTask?{

		return sendRequest(url.rawValue, method: method, headers: headers, queryItems: queryItems,body:body) { data, response, error in
			guard let data = data else {
				return completion(.failure(error ?? NSError(domain: "SomeDomain", code: -1, userInfo: nil)))
			}
			do {
				let decoder = JSONDecoder()
				try completion(.success(decoder.decode(T.self, from: data)))
			} catch let decodingError {
				completion(.failure(decodingError))
			}
		}
	}
	
	
	//MARK:createURLWithComponents
	private func createURLWithComponents(path:String,queryitems:[URLQueryItem]?) -> URL? {
		var urlComponents = URLComponents()
			urlComponents.scheme = "https"
			urlComponents.host = "api.giphy.com"
			urlComponents.path = "/v1/"+path
		
			let apiQueryItem = URLQueryItem(name: "api_key", value: "Syy5qz5AgRWsGSR9ZiheyEACxsZCwxgU")
			if let queryItems=queryitems
			{
				var test:[URLQueryItem]=[]
				test.append(apiQueryItem)
				test.append(contentsOf: queryItems)
				urlComponents.queryItems = test
			}
			else
			{
				urlComponents.queryItems = [apiQueryItem]
			}
		return urlComponents.url
	}
}


