//
//  APIBase.swift
//  PhotoApp
//
//  Created by Mohannad on 5/23/22.
//

import Foundation

class ApiBase: ApiBaseProtocol {
    func request<T>(endpoint: EndPoint, method: Method, params: JSON?, completion: @escaping ApiCompletion<T>) where T : Decodable, T : Encodable {
        let urlStr = "\(Api.url.rawValue)"
        guard  var urlComp = URLComponents(string: urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        urlComp.queryItems = endpoint.info.requestQueryParams
        
        if let body = params , method == .Get {
            body.forEach{ item in
                let value = String(describing: item.value)
                urlComp.queryItems?.append(URLQueryItem(name: item.key, value: value))
            }
        }
        print(urlComp.url?.absoluteString)
        var request = URLRequest(url: urlComp.url!)
        request.httpMethod = method.rawValue
        call(request: request, completion: completion)
    }
    
    func call<T>(request: URLRequest, completion: @escaping ApiCompletion<T>) where T : Decodable, T : Encodable {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data , error == nil else {
                completion(.failure(.server))
                return
            }
            do {
                let info = try JSONDecoder().decode(T.self, from: data)
                completion(.success(info))
            }
            catch {
                debugPrint(error)
                completion(.failure(.parse))
            }
        }
        task.resume()
    }
    
}
