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
import ObjectMapper
@testable import MyRecipeBook

struct MockLoader {
  let data: Data
  let json: String
  
  init?(file: String, withExtension fileExt: String = "json", in bundle: Bundle = .main) {
    guard let path = bundle.path(forResource: file, ofType: fileExt) else {
      return nil
    }
    let pathURL = URL(fileURLWithPath: path)
    do {
      data = try Data(contentsOf: pathURL, options: .dataReadingMapped)
      if let decoded = NSString(data: data, encoding: 0) as String? {
        json = decoded
      } else {
        return nil
      }
    } catch {
      return nil
    }
  }
}

extension MockLoader {
    
  func map<T: Mappable>(to type: T.Type) -> T? {
    return Mapper<T>().map(JSONString: json)
  }
}
