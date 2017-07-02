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

import Quick
import Nimble
@testable import MyRecipeBook

class RecipeSpec: QuickSpec {
    
  override func spec() {
    describe("A Recipe") {
      var recipe: MyRecipeBook.RecipeObject!
      
      beforeEach {
        let testBundle = Bundle(for: type(of: self))
        let mockLoader = MockLoader(file: "Recipe", in: testBundle)
        recipe = mockLoader?.map(to: RecipeObject.self)
      }
      
      it("should be able to create a recipe from json") {
        expect(recipe).toNot(beNil())
      }
      
      it("should have a createdAt") {
        expect(recipe.createdAt).toNot(beNil())
      }
      
      it("should have a descriptionField") {
        expect(recipe.descriptionField).toNot(beNil())
      }
      
      it("should have a difficulty") {
        expect(recipe.difficulty).toNot(beNil())
      }
      
      it("should have a favorite") {
        expect(recipe.favorite).toNot(beNil())
      }
      
      it("should have a id") {
        expect(recipe.id).toNot(beNil())
      }
      
      it("should have a instructions") {
        expect(recipe.instructions).toNot(beNil())
      }
      
      it("should have a name") {
        expect(recipe.name).toNot(beNil())
      }
      
      it("should have a photo") {
        expect(recipe.photo).toNot(beNil())
      }
      
      it("should have a updatedAt") {
        expect(recipe.updatedAt).toNot(beNil())
      }
      
      it("should have a userId") {
        expect(recipe.userId).toNot(beNil())
      }
      
      it("should have a timeSaved") {
        expect(recipe.timeSaved).toNot(beNil())
      }
    }
  }
}
