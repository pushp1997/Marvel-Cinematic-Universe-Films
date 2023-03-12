//
//  MoviesParser.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 12/03/2023.
//

import UIKit

class MoviesParser: NSObject, XMLParserDelegate {
    var movies: [Movie] = []
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
    private var currentCoverUrl: String = "" {
        didSet {
            currentCoverUrl = currentCoverUrl.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentTrailer_url: String = "" {
        didSet {
            currentTrailer_url = currentTrailer_url.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDirected_by: String = "" {
        didSet {
            currentDirected_by = currentDirected_by.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
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
    private var currentPost_credit_scenes: String = "" {
        didSet {
            currentPost_credit_scenes = currentPost_credit_scenes.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentImdb_id: String = "" {
        didSet {
            currentImdb_id = currentImdb_id.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }

    
    private var parserCompletionHandler: (([Movie]) -> Void)?
    
    func parseFeed(url: String, completionHandler: (([Movie]) -> Void)?) -> Void {
        self.parserCompletionHandler = completionHandler
        
        // parse xml data
        let xmlFilePath = Bundle.main.path(forResource: "mcu-movies-list", ofType: "xml")!
        let parser = XMLParser(contentsOf: URL(string:xmlFilePath)!)
        parser!.delegate = self
        parser!.parse()
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
            currentCoverUrl = ""
            currentTrailer_url = ""
            currentDirected_by = ""
            currentPhase = ""
            currentSaga = ""
            currentChronology = ""
            currentPost_credit_scenes = ""
            currentImdb_id = ""
        }
    }
    
    // When the value of an element is found, this method gets called with a string representation of part of the characters of the current element
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
            case "title": currentTitle += string
            case "releaseDate": currentReleaseDate += string
            case "boxOffice": currentBoxOffice += string
            case "duration": currentDuration += string
            case "overview": currentOverview += string
            case "coverUrl": currentCoverUrl += string
            case "trailer_url": currentTrailer_url += string
            case "directed_by": currentDirected_by += string
            case "phase": currentPhase += string
            case "saga": currentSaga += string
            case "chronology": currentChronology += string
            case "post_credit_scenes": currentPost_credit_scenes += string
            case "imdb_id": currentImdb_id += string
            default: break
        }
    }
    
    // When we reach the closing tag of movie is found, this method gets called
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "movie" {
            let movie = Movie(
                title: currentTitle,
                releaseDate: currentReleaseDate,
                boxOffice: Int64(currentBoxOffice)!,
                duration: Int(currentDuration)!,
                overview: currentOverview,
                coverUrl: URL(string: currentCoverUrl)!,
                trailer_url: URL(string: currentTrailer_url)!,
                directed_by: currentDirected_by,
                phase: Int(currentPhase)!,
                saga: currentSaga,
                chronology: Int(currentChronology)!,
                post_credit_scenes: Int(currentPost_credit_scenes)!,
                imdb_id: currentImdb_id
            )
            movies += [movie]
        }
    }
}
