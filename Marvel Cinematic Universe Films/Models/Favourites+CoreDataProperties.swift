//
//  Favourites+CoreDataProperties.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 16/04/2023.
//
//

import Foundation
import CoreData


extension Favourites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourites> {
        return NSFetchRequest<Favourites>(entityName: "Favourites")
    }

    @NSManaged public var added: Bool
    @NSManaged public var movie: MCUMovies?

}

extension Favourites : Identifiable {

}
