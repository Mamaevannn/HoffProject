//
//  CategoriesCollectionViewCell.swift
//  HoffProjectV2
//
//  Created by Наида Мамаева on 08.04.2022.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoriesLbl: UIButton!
    
    func configureCategories(category: Catalog.RelatedCategories) {
        self.categoriesLbl.titleLabel?.text = category.name
        self.categoriesLbl.layer.cornerRadius = 4
    }
}
