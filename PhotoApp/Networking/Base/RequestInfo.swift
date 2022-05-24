//
//  info.swift
//  PhotoApp
//
//  Created by Mohannad on 5/24/22.
//
import Foundation

struct RequestInfo {
    var method : String
    var format : String
    var jsconCallback : Int?
    var text : String?
}

extension RequestInfo {
    init(method :String , format : String) {
        self.init(method: method, format: format, jsconCallback: nil, text: nil)
    }
    
    var requestQueryParams : [URLQueryItem] {
        var params : [URLQueryItem] = []
        params.append(URLQueryItem(name: "method", value: method))
        params.append(URLQueryItem(name: "api_key", value: Api.key.rawValue))
        params.append(URLQueryItem(name: "format", value: Api.format.rawValue))
        
        if let callback = jsconCallback{
            let callbackValue = String(describing: callback)
            params.append(URLQueryItem(name: "nojsoncallback", value: callbackValue))
        }
        
        if let text = text{
            let textValue = String(describing: text)
            params.append(URLQueryItem(name: "text", value: textValue))
        }
        return params
    }
}
