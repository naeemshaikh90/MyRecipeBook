//
//  Photo+Persistable.swift
//  MyRecipeBook
//
//  Created by Naeem Shaikh on 28/06/17.
//  Copyright © 2017 Naeem G Shaikh. All rights reserved.
//

import Foundation

extension Photo: Persistable {
    
    public init(managedObject: PhotoObject) {
        thumbnailUrl = managedObject.thumbnailUrl
        url = managedObject.url
    }
    
    public func managedObject() -> PhotoObject {
        let photo = PhotoObject()
        photo.thumbnailUrl = thumbnailUrl
        photo.url = url
        return photo
    }
}

extension Photo {
    
    public enum PropertyValue: PropertyValueType {
        case thumbnailUrl(String)
        case url(String)
        
        public var propertyValuePair: PropertyValuePair {
            switch self {
            case .thumbnailUrl(let thumbnailUrl):
                return ("thumbnailUrl", thumbnailUrl)
            case .url(let url):
                return ("url", url)
            }
        }
    }
}

