//
//  CoreDataManagerProtocol.swift
//  PhotoApp
//
//  Created by Mohannad on 5/28/22.
//
import CoreData

protocol CoreDataManagerProtocol {
    
    func add<T:NSManagedObject , S : AnyObject>(type : T.Type , entities : [S])
    
    func fetch<T: NSManagedObject>(entity : T.Type) -> [T]?
    
    func delete<T: NSManagedObject>(entity : T)
    
    func deleteAll<T:NSManagedObject>(entity : T.Type)
    
    func setup(completion : @escaping  () ->())
}

extension CoreDataManagerProtocol {
    func setup(completion : @escaping  () ->()) {
        /* Make it a optional method */
    }
}
