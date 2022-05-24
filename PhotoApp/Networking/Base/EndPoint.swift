//
//  EndPoint.swift
//  PhotoApp
//
//  Created by Mohannad on 5/23/22.
//

import Foundation

public typealias JSON = [String : Any]

enum ApiError : Error {
    case server
    case parse
    case invalidUrl
    case internetOffline
    
    var message : String {
        switch self {
        case .internetOffline:
            return "Please make sure you are connected to the internet"
        case .server :
            return "an internal error occured in server side please try again later"
        default:
            return "an internal error occured"
        }
    }
}

enum Method : String {
    case Get
    case Post
}

enum EndPoint {
    
    case getPhotos
    case getProfile
    
    var info : RequestInfo {
        switch self {
          case .getPhotos:
             return RequestInfo(method: "flickr.photos.search", format: "json", jsconCallback: 50, text: "Color")
          case .getProfile:
            return RequestInfo(method: "flickr.photos.profile", format: "json")
        }
    }
}


