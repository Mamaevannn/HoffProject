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
    @IBOutlet weak var tagLbl: UILabel! 
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var specialOffer: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var favoriteButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(item: Catalog.Items) {
        theItem = item
        self.ratingView.rating = item.rating
        self.ratingView.text = "(\(item.numberOfReviews))"
        self.nameLBL.text = item.name
        self.statusLbl.text = item.statusText
       
        // old and new price. TODO: format price with spacing and add to cross out old price
        self.newPrice.text = "\(item.prices.new) ₽"
        if item.prices.old == item.prices.new {
            self.oldPrice.text = ""
        } else {
        self.oldPrice.text = "\(item.prices.old) ₽"
        }
        // best price and discount
        if item.isBestPrice {
            self.specialOffer.text = "  Лучшая цена  "
            self.specialOffer.backgroundColor = #colorLiteral(red: 0.9917286038, green: 0.7743743062, blue: 0, alpha: 1)
            self.specialOffer.textColor = .white
            self.specialOffer.layer.cornerRadius = 2
        } else if item.discount != 0 {
            self.specialOffer.text = "  -\(item.discount) %  "
            self.specialOffer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0, blue: 0, alpha: 1)
            self.specialOffer.textColor = .white
            self.specialOffer.layer.cornerRadius = 2
    
        } else {
            self.specialOffer.text = .none
        }
        
        // image downloading
        itemImage.sd_setImage(with: URL(string: item.image),
                              placeholderImage: UIImage(systemName: "photo"),
                              options: .continueInBackground,
                              completed: nil)
        
        if CatalogUserDefaults.shared.isFavorite(item: item) {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
        } else {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "notfav"), for: .normal)
        }
    }
    
    var theItem: Catalog.Items!
   
    @IBAction func didTapFavButton(_ sender: UIButton) {
        let _ = CatalogUserDefaults.shared.addOrRemoveFavorite(item: theItem)
        if CatalogUserDefaults.shared.isFavorite(item: theItem) {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
        } else {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "notfav"), for: .normal)
        }
    }
}


