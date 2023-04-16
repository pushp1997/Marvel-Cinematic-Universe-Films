//
//  MoviesParser.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 12/03/2023.
//

import UIKit
import CoreData

class MoviesParser: NSObject, XMLParserDelegate {
    private var currentElement = ""
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentReleaseDate: String = "" {
        didSet {
            currentReleaseDate = currentReleaseDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentBoxOffice: String = "" {
        didSet {
            currentBoxOffice = currentBoxOffice.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDuration: String = "" {
        didSet {
            currentDuration = currentDuration.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentOverview: String = "" {
        didSet {
            currentOverview = currentOverview.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentCover: String = "" {
        didSet {
            currentCover = currentCover.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentTrailerUrl: String = "" {
        didSet {
            currentTrailerUrl = currentTrailerUrl.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDirectedBy: String = "" {
        didSet {
            currentDirectedBy = currentDirectedBy.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentPhase: String = "" {
        didSet {
            currentPhase = currentPhase.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentSaga: String = "" {
        didSet {
            currentSaga = currentSaga.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentChronology: String = "" {
        didSet {
            currentChronology = currentChronology.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentPostCreditScenes: String = "" {
        didSet {
            currentPostCreditScenes = currentPostCreditScenes.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentImdbId: String = "" {
        didSet {
            currentImdbId = currentImdbId.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }

    // MARK: - Core data objects and methods
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    var entity: NSEntityDescription!;
    var managedMCUMoviesObject: MCUMovies!;
    var managedFavouritesObject: Favourites!;

    func parseMovies() {
        // parse xml data
        if let xmlFilePath = Bundle.main.path(forResource: "mcu-movies-list", ofType: "xml") {
            do {
                let data = try Data(contentsOf: URL(filePath: xmlFilePath))
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            } catch {
                // Handle error here
            }
        }
    }
    
    // MARK: - XML Parser Delegate
    
    // When we reach the opening tag of movie is found, this method gets called
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // We assign the name of the element to currentElement, if the item tag is found, we reset the temporary variables of title, description and pubdate for later use
        currentElement = elementName
        if currentElement == "movie" {
            currentTitle = ""
            currentReleaseDate = ""
            currentBoxOffice = ""
            currentDuration = ""
            currentOverview = ""
            currentCover = ""
            currentTrailerUrl = ""
            currentDirectedBy = ""
            currentPhase = ""
            currentSaga = ""
            currentChronology = ""
            currentPostCreditScenes = ""
            currentImdbId = ""
        }
    }
    
    // When the value of an element is found, this method gets called with a string representation of part of the characters of the current element
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
            case "title": currentTitle += string
            case "release_date": currentReleaseDate += string
            case "box_office": currentBoxOffice += string
            case "duration": currentDuration += string
            case "overview": currentOverview += string
            case "cover": currentCover += string
            case "trailer_url": currentTrailerUrl += string
            case "directed_by": currentDirectedBy += string
            case "phase": currentPhase += string
            case "saga": currentSaga += string
            case "chronology": currentChronology += string
            case "post_credit_scenes": currentPostCreditScenes += string
            case "imdb_id": currentImdbId += string
            default: break
        }
    }
    
    // When we reach the closing tag of movie is found, this method gets called
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "movie" {
            entity = NSEntityDescription.entity(forEntityName: "MCUMovies", in: self.context);
            managedMCUMoviesObject = MCUMovies(entity: entity, insertInto: self.context);
            entity = NSEntityDescription.entity(forEntityName: "Favourites", in: self.context);
            managedFavouritesObject = Favourites(entity: entity, insertInto: self.context);

            // Populating managed object with parsed fields
            managedMCUMoviesObject.title = currentTitle
            managedMCUMoviesObject.releaseDate = currentReleaseDate
            managedMCUMoviesObject.boxOffice = Int64(currentBoxOffice)!
            managedMCUMoviesObject.duration = Int64(currentDuration)!
            managedMCUMoviesObject.overview = currentOverview
            managedMCUMoviesObject.cover = UIImage(named: currentCover)?.jpegData(compressionQuality: 0)
            managedMCUMoviesObject.trailerURL = currentTrailerUrl
            managedMCUMoviesObject.directedBy = currentDirectedBy
            managedMCUMoviesObject.phase = Int16(currentPhase)!
            managedMCUMoviesObject.saga = currentSaga
            managedMCUMoviesObject.chronology = Int16(currentChronology)!
            managedMCUMoviesObject.postCreditScenes = Int16(currentPostCreditScenes)!
            managedMCUMoviesObject.imdbID = currentImdbId

            managedFavouritesObject.movie = managedMCUMoviesObject
            
            do {
                try self.context.save()
            } catch {
              print("Could not save the data.")
            }
        }
    }

}
