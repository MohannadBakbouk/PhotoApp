//
//  APIBaseProtocol.swift
//  PhotoApp
//
//  Created by Mohannad on 5/23/22.
//

import Foundation

typealias ApiCompletion<T : Codable> = (Result<T , ApiError>) -> Void

protocol ApiBaseProtocol {
    func request<T: Codable>(endpoint : EndPoint , method : Method , params : JSON? , completion : @escaping ApiCompletion<T>)
    
    func call<T: Codable>(request : URLRequest , completion : @escaping ApiCompletion<T>)
}

