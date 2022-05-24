//
//  SearchParams.swift
//  PhotoApp
//
//  Created by Mohannad on 5/24/22.
//

import Foundation

class SearchParams {
    var page : Int
    var size : Int
    var query : String?
    
    init(query : String? = nil , page : Int , size : Int) {
        self.query = query
        self.page = page
        self.size = size
    }
    
    var  toDictionary : JSON {
        var info : JSON = ["page" : page , "per_page" : size]
        if let searchQuery = query {
            info["query"] =  searchQuery
        }
        return info
    }
}

