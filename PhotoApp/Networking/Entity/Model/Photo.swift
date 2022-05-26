//
//  Photo.swift
//  PhotoApp
//
//  Created by Mohannad on 5/24/22.
//
import Foundation
struct Photo : Codable {
    var id : String
    var owner : String
    var secret : String
    var server : String
    var farm : Int
    var title : String
    var ispublic : Int
    var isfriend : Int
    var isfamily : Int
}


extension Photo {
    /* I've tried the simple way to concate the url but i didnt work and it fails some time with
     casting it to url and sometime return faild download image unspoorted url*/
    var url : String? {
        var comps = URLComponents()
        comps.scheme = "https"
        comps.host = "farm\(farm.toString).static.flickr.com"
        comps.path = "/\(server)/\(id)_\(secret).jpg"
        return comps.url?.absoluteString
    }
}
