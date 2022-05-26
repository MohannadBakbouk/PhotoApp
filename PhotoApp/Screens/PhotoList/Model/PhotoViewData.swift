//
//  PhotoViewData.swift
//  PhotoApp
//
//  Created by Mohannad on 5/24/22.
//
import Foundation

class PhotoViewData {
    var title : String
    var urlString : String
    var freindMeta : PhotoMetaData
    var familyMeta : PhotoMetaData
    var PublicMeta : PhotoMetaData
    
    init(info : Photo) {
        title = info.title
        urlString = info.url ?? ""
        print(urlString , "\(title)")
        freindMeta = PhotoMetaData(status: info.isfriend)
        familyMeta = PhotoMetaData(status: info.isfamily)
        PublicMeta = PhotoMetaData(status: info.ispublic)
    }
}

class PhotoMetaData {
    var icon : Icons
    var color : Colors
    
    init (status : Int){
        icon = status == 1 ? .checkmark : .xmark
        color = status == 1 ? .flatGreen : .flatRed
    }
}
