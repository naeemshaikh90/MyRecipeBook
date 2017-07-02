/*
 * Copyright © 2017-present Naeem G Shaikh. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

extension Recipe: Persistable {
    
    public init(managedObject: RecipeObject) {
        createdAt = managedObject.createdAt
        descriptionField = managedObject.descriptionField
        difficulty = managedObject.difficulty
        favorite = managedObject.favorite
        id = managedObject.id
        instructions = managedObject.instructions
        name = managedObject.name
        updatedAt = managedObject.updatedAt
        userId = managedObject.userId
        photo = managedObject.photo.flatMap(Photo.init(managedObject:))
        timeSaved = managedObject.timeSaved
    }
    
    public func managedObject() -> RecipeObject {
        let recipe = RecipeObject()
        recipe.createdAt = createdAt
        recipe.descriptionField = descriptionField
        recipe.difficulty = difficulty
        recipe.favorite = favorite
        recipe.id = id
        recipe.instructions = instructions
        recipe.name = name
        recipe.updatedAt = updatedAt
        recipe.userId = userId
        recipe.photo = photo?.managedObject()
        recipe.timeSaved = timeSaved
        return recipe
    }
}

extension Recipe {
    
    public enum PropertyValue: PropertyValueType {
        case createdAt(String)
        case descriptionField(String)
        case difficulty(Int)
        case favorite(Bool)
        case id(Int)
        case instructions(String)
        case name(String)
        case updatedAt(String)
        case userId(Int)
        case photo(PhotoObject)
        case timeSaved(Date)
        
        public var propertyValuePair: PropertyValuePair {
            switch self {
            case .createdAt(let createdAt):
                return ("createdAt", createdAt)
            case .descriptionField(let descriptionField):
                return ("descriptionField", descriptionField)
            case .difficulty(let difficulty):
                return("difficulty", difficulty)
            case .favorite(let favorite):
                return ("favorite", favorite)
            case .id(let id):
                return ("id", id)
            case .instructions(let instructions):
                return ("instructions", instructions)
            case .name(let name):
                return ("name", name)
            case .updatedAt(let updatedAt):
                return ("updatedAt", updatedAt)
            case .userId(let userId):
                return ("userId", userId)
            case .photo(let photo):
                return ("photo", photo)
            case .timeSaved(let timeSaved):
                return ("timeSaved", timeSaved)
                
            }
        }
    }
}

