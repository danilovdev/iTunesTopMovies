//
//  Author.swift
//  iTunesTopMoviesPart1
//
//  Created by Alexey Danilov on 27.05.2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

struct Author {
    
    var name: String?
    
    var uriStr: String?
    
    init(dict: [String: Any]) {
        if let nameProperty = dict["name"] as? [String: Any],
            let nameValue = nameProperty["label"] as? String {
            name = nameValue
        }
        if let uriProperty = dict["uri"] as? [String: Any],
            let uriValue = uriProperty["label"] as? String {
            uriStr = uriValue
        }
    }
    
}
