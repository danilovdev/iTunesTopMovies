//
//  Movie.swift
//  iTunesTopMoviesPart1
//
//  Created by Alexey Danilov on 26.05.2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//


struct Movie {
    
    var name: String?
    
    var title: String?
    
    var rights: String?
    
    var rentalPrice: String?
    
    var price: String?
    
    var category: String?
    
    var releaseDate: String?
    
    var artist: String?
    
    var itunesUrlStr: String?
    
    var previewUrlStr: String?
    
    var contentType: String?
    
    var imagePreviewUrlStr: String?
    
    var imageFullUrlStr: String?
    
    init(dict: Dictionary<String, Any>) {
        if let imageProperty = dict["im:image"] as? [[String: Any]],
            let imagePreviewValue = imageProperty[0]["label"] as? String {
            imagePreviewUrlStr = imagePreviewValue
        }
        if let imageProperty = dict["im:image"] as? [[String: Any]],
            let imageFullValue = imageProperty[2]["label"] as? String {
            imageFullUrlStr = imageFullValue
        }
        if let linkProperty = dict["link"] as? [[String: Any]],
            let itunesLinkAttributes = linkProperty[0]["attributes"] as? [String: String],
            let itunesUrlValue = itunesLinkAttributes["href"] {
            itunesUrlStr = itunesUrlValue
        }
        if let linkProperty = dict["link"] as? [[String: Any]],
            let previewLinkAttributes = linkProperty[1]["attributes"] as? [String: String],
            let previewUrlValue = previewLinkAttributes["href"] {
            previewUrlStr = previewUrlValue
        }
        if let titleProperty = dict["title"] as? [String: String],
            let titleValue = titleProperty["label"] {
            title = titleValue
        }
        if let nameProperty = dict["name"] as? [String: String],
            let nameValue = nameProperty["label"] {
            name = nameValue
        }
        if let rightsProperty = dict["rights"] as? [String: String],
            let rightsValue = rightsProperty["label"] {
            rights = rightsValue
        }
        if let priceProperty = dict["im:price"] as? [String: Any],
            let priceValue = priceProperty["label"] as? String {
            price = priceValue
        }
        if let rentalPriceProperty = dict["im:rentalPrice"] as? [String: Any],
            let rentalPriceValue = rentalPriceProperty["label"] as? String {
            rentalPrice = rentalPriceValue
        }
        if let artistProperty = dict["im:artist"] as? [String: String],
            let artistValue = artistProperty["label"] {
            artist = artistValue
        }
        if let categoryProperty = dict["category"] as? [String: Any],
            let attributesProperty = categoryProperty["attributes"] as? [String: String],
            let categoryValue = attributesProperty["label"] {
            category = categoryValue
        }
        if let releaseDateProperty = dict["releaseDate"] as? [String: Any],
            let attributesProperty = releaseDateProperty["attributes"] as? [String: String],
            let releaseDateValue = attributesProperty["label"] {
            releaseDate = releaseDateValue
        }
        if let contentTypeProperty = dict["im:contentType"] as? [String: Any],
            let attributesProperty = contentTypeProperty["attributes"] as? [String: String],
            let contentTypeValue = attributesProperty["label"] {
            contentType = contentTypeValue
        }
    }
}
