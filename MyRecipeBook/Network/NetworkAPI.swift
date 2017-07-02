/**
 * Copyright © 2017-present Naeem Shaikh
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
import Moya

enum NetworkAPI {
  
  // (C)reate recipes
  case createRecipe()
  
  // (R)etrieve recipes
  case retrieveRecipes()
  
  // (U)pdate recipes
  case updateRecipe(String)
  
  // (D)elete recipes
  case deleteRecipe(String)
}

extension NetworkAPI: TargetType {
  
  /// The projects's base `URL`.
  var baseURL: URL { return URL(string: "http://hyper-recipes.herokuapp.com/")! }
  
  /// The path to be appended to `baseURL` to form the full `URL`.
  var path: String {
    switch self {
    case .createRecipe(), .retrieveRecipes():
      return "recipes"
      
    case .updateRecipe(let recipeId), .deleteRecipe(let recipeId):
      return "recipes/\(recipeId)"
    }
  }
  
  /// The HTTP method used in the request.
  var method: Moya.Method {
    switch self {
    case .createRecipe:
      return .post
      
    case .retrieveRecipes:
      return .get
      
    case .updateRecipe:
      return .put
      
    case .deleteRecipe:
      return .delete
    }
  }
  
  /// Authorization parameters to include in httpHeaderFields
  func authParameters() -> [String: String] {
    return ["Authorization": "Token token=b3619d1e0a84331c2d42"]
  }
  
  /// The parameters to be incoded in the request.
  var parameters: [String: Any]? {
    switch self {
      //MARK: TODO: Config Params for all cases  
    default:
      return ["": ""]
    }
  }
  
  /// The method used for parameter encoding.
  var parameterEncoding: ParameterEncoding {
    return URLEncoding.default
  }
  
  /// Provides stub data for use in testing.
  var sampleData: Data {
    switch self {
    default:
      return Data()
    }
  }
  
  /// The type of HTTP task to be performed.
  var task: Task {
    switch self {
    case .createRecipe():
      //MARK: TODO: Change to An upload task.
      return .request
    default:
      return .request
    }
  }
}
