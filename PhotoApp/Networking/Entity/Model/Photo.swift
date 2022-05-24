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
