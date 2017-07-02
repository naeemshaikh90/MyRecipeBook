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

import UIKit
import Reachability
import SwifterSwift

let kErrorCommon = "Something went wrong, please try again later."
let kErrorNotConnected = "No Internet Connection. Please Try Again"

class CommonUtility: NSObject {
  
  class func isConnected() -> Bool{
    let reachability:Reachability = Reachability.forInternetConnection()
    let networkStatus = reachability.currentReachabilityStatus().rawValue
    return networkStatus != 0
  }
  
  class func showNotConnected() {
    ShowAlert(myTitle: "Error", myMessage: kErrorNotConnected)
  }
  
  class func showError(_ error: Error) {
    ShowAlert(myTitle: "Error", myMessage: error.localizedDescription)
  }
  
  class func ShowAlert(myTitle: String , myMessage message: String) {
    let alert = UIAlertController(title: myTitle, message: message)
    alert.show()
  }
}
