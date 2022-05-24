//
//  SearchPhotoResponse.swift
//  PhotoApp
//
//  Created by Mohannad on 5/24/22.
//
import Foundation
struct SearchPhotoResponse : Codable {
    var photos : SearchPhotoResults?
    var stat : String
}

struct  SearchPhotoResults : Codable {
    var page : Int
    var pages: Int
    var perpage : Int
    var total :  Int
    var photo : [Photo]
}
