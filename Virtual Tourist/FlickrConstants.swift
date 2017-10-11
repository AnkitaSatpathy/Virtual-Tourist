//
//  FlickrConstants.swift
//  Virtual Tourist
//
//  Created by Ankita Satpathy on 11/10/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import Foundation

extension FlickrClient {
    
    struct Constants {
        static let APIKey = "37fa54a6d3c2bec4c5d66165d1ca18f5"
        static let BaseURL = "https://api.flickr.com/services/rest/"
    }
    
    struct Methods {
        static let Search = "flickr.photos.search"
    }
    
    struct URLKeys {
        static let APIKey = "api_key"
        static let BoundingBox = "bbox"
        static let Format = "format"
        static let Extras = "extras"
        static let Latitude = "lat"
        static let Longitude = "lon"
        static let Method = "method"
        static let NoJSONCallback = "nojsoncallback"
        static let Page = "page"
        static let PerPage = "per_page"
    }
    
    struct URLValues {
        static let JSONFormat = "json"
        static let URLMediumPhoto = "url_m"
    }
    
    struct JSONResponseKeys {
        static let Status = "stat"
        static let Code = "code"
        static let Message = "message"
        static let Pages = "pages"
        static let Photos = "photos"
        static let Photo = "photo"
    }
    
    struct JSONResponseValues {
        
        static let Fail = "fail"
        static let Ok = "ok"
    }
}
