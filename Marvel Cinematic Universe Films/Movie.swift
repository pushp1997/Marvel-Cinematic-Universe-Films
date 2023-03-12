//
//  Movie.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 23/02/2023.
//

import Foundation

class Movie {
    var title: String
    var releaseDate: String
    var boxOffice: String
    var duration: String
    var overview: String
    var cover: String
    var trailerUrl: URL
    var directedBy: String
    var phase: String
    var saga: String
    var chronology: String
    var postCreditScenes: String
    var imdbId: String
    
    init(title: String, releaseDate: String, boxOffice: String, duration: String, overview: String, cover: String, trailerUrl: URL, directedBy: String, phase: String, saga: String, chronology: String, postCreditScenes: String, imdbId: String) {
        self.title = title
        self.releaseDate = releaseDate
        self.boxOffice = boxOffice
        self.duration = duration
        self.overview = overview
        self.cover = cover
        self.trailerUrl = trailerUrl
        self.directedBy = directedBy
        self.phase = phase
        self.saga = saga
        self.chronology = chronology
        self.postCreditScenes = postCreditScenes
        self.imdbId = imdbId
    }
}
