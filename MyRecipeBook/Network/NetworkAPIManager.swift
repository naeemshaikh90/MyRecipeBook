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
import RxSwift
import RealmSwift
import ObjectMapper
import Moya_ObjectMapper

extension Response {
  
  func removeAPIWrappers() -> Response {
    guard let json = try? self.mapJSON() as? [[String: AnyObject]],
      let results = json,
      let newData = try? JSONSerialization.data(withJSONObject: results,
                                                options: .prettyPrinted) else {
        return self
    }
    
    let newResponse = Response(statusCode: statusCode,
                               data: newData,
                               response: response)
    return newResponse
  }
}

struct NetworkAPIManager {
  
  // Add httpHeaderFields
  let endpointClosure = { (target: NetworkAPI) -> Endpoint<NetworkAPI> in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    return Endpoint<NetworkAPI>(url: url,
                                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                method: target.method,
                                parameters: target.parameters,
                                parameterEncoding: target.parameterEncoding,
                                httpHeaderFields: target.authParameters())
  }
  
  let provider: RxMoyaProvider<NetworkAPI>
  let disposeBag = DisposeBag()
  
  init() {
    provider = RxMoyaProvider<NetworkAPI>(endpointClosure: endpointClosure)
  }
}

extension NetworkAPIManager {
  
  fileprivate func requestObject<T: Mappable>(_ token: NetworkAPI, type: T.Type,
                                 completion: @escaping (T?) -> Void) {
    provider.request(token)
      .debug()
      .mapObject(T.self)
      .subscribe { event -> Void in
        switch event {
        case .next(let parsedObject):
          self.saveOfflineData([parsedObject])
          completion(parsedObject)
        case .error(let error):
          CommonUtility.showError(error)
          completion(nil)
        default:
          break
        }
      }.addDisposableTo(disposeBag)
  }
  
  fileprivate func requestArray<T: Mappable>(_ token: NetworkAPI, type: T.Type,
                                completion: @escaping ([T]?) -> Void) {
    provider.request(token)
      .debug()
      .map { response -> Response in
        return response.removeAPIWrappers()
      }
      .mapArray(T.self)
      .subscribe { event -> Void in
        switch event {
        case .next(let parsedArray):
          self.saveOfflineData(parsedArray)
          completion(parsedArray)
        case.error(let error):
          CommonUtility.showError(error)
          completion(nil)
        default:
          break
        }
      }.addDisposableTo(disposeBag)
  }
  
  fileprivate func saveOfflineData(_ parsedElements: [Any]) {
    do {
      let realm = try Realm()
      try realm.write {
        for element in parsedElements {
          realm.add(element as! Object, update: true)
        }
      }
    } catch let error as NSError {
      CommonUtility.showError(error)
    }
  }
}

protocol NetworkAPICalls {
  func recipes(completion: @escaping ([RecipeObject]?) -> Void)
}

extension NetworkAPIManager: NetworkAPICalls {
  func recipes(completion: @escaping ([RecipeObject]?) -> Void) {
    requestArray(.retrieveRecipes(),
                 type: RecipeObject.self,
                 completion: completion)
  }
}
