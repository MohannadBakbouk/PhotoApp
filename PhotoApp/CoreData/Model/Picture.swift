//
//  picture.swift
//  PhotoApp
//
//  Created by Mohannad on 5/28/22.
//
import CoreData

extension Picture {
    override func populate(with info : AnyObject){
        guard let info = info as? PhotoViewData else { return}
            title = info.title
            url = info.urlString
            familyColor = info.familyMeta.color.rawValue
            familyIcon = info.familyMeta.icon.rawValue
            publicColor = info.PublicMeta.color.rawValue
            publicIcon = info.PublicMeta.icon.rawValue
            friendColor = info.freindMeta.color.rawValue
            friendIcon = info.freindMeta.icon.rawValue
    }
}
