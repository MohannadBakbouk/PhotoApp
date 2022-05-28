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
        freindMeta = PhotoMetaData(status: info.isfriend)
        familyMeta = PhotoMetaData(status: info.isfamily)
        PublicMeta = PhotoMetaData(status: info.ispublic)
    }
    
    init(stored : Picture){
        title = stored.title ?? ""
        urlString = stored.url ?? ""
        freindMeta = PhotoMetaData(color: stored.friendColor , icon:  stored.friendIcon )
        familyMeta = PhotoMetaData(color: stored.familyColor, icon:  stored.familyIcon )
        PublicMeta = PhotoMetaData(color: stored.publicColor, icon:  stored.publicIcon)
    }
}

class PhotoMetaData {
    var icon : Icons
    var color : Colors
    
    init (status : Int){
        icon = status == 1 ? .checkmark : .xmark
        color = status == 1 ? .flatGreen : .flatRed
    }
    
    init (color : String? , icon : String?){
        self.icon = Icons(rawValue : icon!) ?? .xmark
        self.color = Colors(rawValue: color!) ?? .flatRed
    }
}
