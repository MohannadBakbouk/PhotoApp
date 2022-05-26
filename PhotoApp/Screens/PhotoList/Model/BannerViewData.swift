//
//  BannerViewData.swift
//  PhotoApp
//
//  Created by Mohannad on 5/26/22.
//
import Foundation

class BannerViewData {
    var space : String
    var message : String
    
    init(space : String , message : String) {
        self.space = space
        self.message = message
    }
    
    convenience init(){
        self.init(space : "350 * 150" , message : "Add your advertisement here")
    }
}
