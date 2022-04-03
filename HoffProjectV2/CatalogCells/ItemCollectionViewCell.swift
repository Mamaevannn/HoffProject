//
//  ItemCollectionViewCell.swift
//  HoffProjectV2
//
//  Created by Наида Мамаева on 02.04.2022.
//

import UIKit
import SDWebImage
import Cosmos

class ItemCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var tagLbl: UILabel! // ????
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var specialOffer: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var favoriteButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(item: Catalog.Items) {
        
        self.ratingView.rating = item.rating
        self.ratingView.text = "(\(item.numberOfReviews))"
        self.nameLBL.text = item.name
        self.statusLbl.text = item.statusText
        self.newPrice.text = "\(item.prices.new) ₽"
        self.oldPrice.text = "\(item.prices.old) ₽" // отформатировать и добавить черточку
        
        itemImage.sd_setImage(with: URL(string: item.image),
                              placeholderImage: UIImage(systemName: "photo"),
                              options: .continueInBackground,
                              completed: nil)
    }
}


