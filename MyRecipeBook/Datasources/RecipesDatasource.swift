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

private enum SectionType {
  case RecipeCell
}

private struct Section {
  var type: SectionType
  var items: Int
}

final class RecipesDatasource: NSObject, RecipesCollectionDatasource {
  
  var recipes: [RecipeObject] = []
  fileprivate var sections = [Section]()
  
  weak var collectionView: UICollectionView?
  weak var delegate: UICollectionViewDelegate?
  
  required init(recipes: [RecipeObject], collectionView: UICollectionView, delegate: UICollectionViewDelegate) {
    self.recipes = recipes
    self.collectionView = collectionView
    self.delegate = delegate
    super.init()
    sections = [
      Section(type: .RecipeCell, items: recipes.count)
    ]
    collectionView.register(cellType: RecipeCell.self)
    self.setupCollectionView()
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sections.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sections[section].items
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch sections[indexPath.section].type {
    case .RecipeCell:
      return recipeCellAt(indexPath)
    }
  }
  
  func recipeCellAt(_ indexPath: IndexPath) -> RecipeCell {
    let cell = self.collectionView!.dequeueReusableCell(for: indexPath, cellType: RecipeCell.self)
    let recipe = self.recipes[indexPath.row]
    let imageUrl = recipe.photo?.url
    cell.setup(name: recipe.name, imageUrl: imageUrl ?? "")
    return cell
  }
}

class RecipesCollectionDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  let delegate: RecipesDelegate
  
  init(_ delegate: RecipesDelegate) {
    self.delegate = delegate
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate.didSelectRecipe(at: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.size.width
    return RecipeCell.size(for: width)
  }
}
