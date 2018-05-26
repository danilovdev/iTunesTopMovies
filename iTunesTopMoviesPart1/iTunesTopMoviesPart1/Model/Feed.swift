//
//  Feed.swift
//  iTunesTopMoviesPart1
//
//  Created by Alexey Danilov on 27.05.2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

struct Feed {
    
    var author: Author?
    
    var movies: [Movie]?
    
    init(dict: [String: Any]) {
        if let authorProperty = dict["author"] as? [String : Any] {
            author = Author(dict: authorProperty)
        }
        if let entryProperty = dict["entry"] as? [[String : Any]] {
            for item in entryProperty {
                let movie = Movie(dict: item)
                if movies == nil {
                    movies = []
                }
                movies?.append(movie)
            }
        }
    }
}
