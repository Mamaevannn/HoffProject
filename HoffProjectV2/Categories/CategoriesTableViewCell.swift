//
//  CategoriesTableViewCell.swift
//  HoffProjectV2
//
//  Created by Наида Мамаева on 08.04.2022.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    let service = NetworkService()
    private var categories: [Catalog.RelatedCategories] = []
    @IBOutlet weak var CategoriesCollectionView: UICollectionView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        service.getData(sortBy: "popular", sortType: "desc")
        service.completionHandler { [weak self] (items, status, message) in
            if status {
                guard let self = self else {return}
                guard let _items = items?.relatedCategories else {return}
                self.categories = _items
                self.CategoriesCollectionView.reloadData()
            }
        }
        self.CategoriesCollectionView.delegate = self
        self.CategoriesCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    var indexpath = IndexPath(item: 0, section: 0)
    weak var categoryDelegate: CategoryDelegate?
    
    
    // TODO: что-то не так с делегатами 
    @IBAction func categoryChanged(_ sender: UIButton) {
        categoryDelegate?.setData(categoryId: categories[indexpath.row].id)
    }
    
}

extension CategoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CategoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCell", for: indexPath) as! CategoriesCollectionViewCell
        let category = categories[indexPath.row]
        cell.configureCategories(category: category )
        return cell
    }
    
    
    
}
