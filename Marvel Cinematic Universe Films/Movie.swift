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
    var boxOffice: Int64
    var duration: Int
    var overview: String
    var coverUrl: URL
    var trailer_url: URL
    var directed_by: String
    var phase: Int
    var saga: String
    var chronology: Int
    var post_credit_scenes: Int
    var imdb_id: String
    
    init(title: String, releaseDate: String, boxOffice: Int64, duration: Int, overview: String, coverUrl: URL, trailer_url: URL, directed_by: String, phase: Int, saga: String, chronology: Int, post_credit_scenes: Int, imdb_id: String) {
        self.title = title
        self.releaseDate = releaseDate
        self.boxOffice = boxOffice
        self.duration = duration
        self.overview = overview
        self.coverUrl = coverUrl
        self.trailer_url = trailer_url
        self.directed_by = directed_by
        self.phase = phase
        self.saga = saga
        self.chronology = chronology
        self.post_credit_scenes = post_credit_scenes
        self.imdb_id = imdb_id
    }
}
