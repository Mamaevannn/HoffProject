//
//  CategoriesCollectionViewCell.swift
//  HoffProjectV2
//
//  Created by Наида Мамаева on 08.04.2022.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoriesLbl: UILabel!
    
    func configureCategories(category: Catalog.RelatedCategories) {
        self.categoriesLbl.text = category.name
        self.categoriesLbl.layer.cornerRadius = 4
        self.categoriesLbl.layer.backgroundColor = UIColor(red: 0.945, green: 0.957, blue: 0.976, alpha: 1).cgColor
    }
}
