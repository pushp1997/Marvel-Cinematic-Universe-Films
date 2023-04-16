//
//  MCUMovies+CoreDataProperties.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 16/04/2023.
//
//

import Foundation
import CoreData


extension MCUMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MCUMovies> {
        return NSFetchRequest<MCUMovies>(entityName: "MCUMovies")
    }

    @NSManaged public var title: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var boxOffice: Int64
    @NSManaged public var duration: Int64
    @NSManaged public var overview: String?
    @NSManaged public var cover: Data?
    @NSManaged public var trailerURL: String?
    @NSManaged public var directedBy: String?
    @NSManaged public var phase: Int16
    @NSManaged public var saga: String?
    @NSManaged public var chronology: Int16
    @NSManaged public var postCreditScenes: Int16
    @NSManaged public var imdbID: String?
    @NSManaged public var favourite: Favourites?

}

extension MCUMovies : Identifiable {

}
