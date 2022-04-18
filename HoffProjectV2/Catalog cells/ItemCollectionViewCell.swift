//
//  ItemCollectionViewCell.swift
//  HoffProjectV2
//
//  Created by Наида Мамаева on 02.04.2022.
//

import UIKit
import SDWebImage
import Cosmos
//import SwiftUI

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
    @IBOutlet weak var tagPoint: UIView!
    
    var indexpath = IndexPath(item: 0, section: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(item: Catalog.Items, indexPath: IndexPath) {
        theItem = item
        self.ratingView.rating = item.rating
        self.ratingView.text = "(\(item.numberOfReviews))"
        self.ratingView.settings.fillMode = .precise
        self.nameLBL.text = item.name
        self.statusLbl.text = item.statusText
       
        // fomatted old and new price with seperator and crossing
        self.newPrice.text = String(item.prices.new.formattedWithSeperator) + " ₽"
        if item.prices.old == item.prices.new {
            self.oldPrice.text = .none
        } else {
            let crossedPrice = NSAttributedString(string: "\(item.prices.old)", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            self.oldPrice.attributedText = crossedPrice
            self.oldPrice.text = String(item.prices.old.formattedWithSeperator) + " ₽"
        }
        
        // best price and discount
        self.specialOffer.layer.cornerRadius = 2
        self.specialOffer.textColor = .white
        if item.isBestPrice {
            self.specialOffer.text = "  Лучшая цена  "
            self.specialOffer.backgroundColor = #colorLiteral(red: 0.9917286038, green: 0.7743743062, blue: 0, alpha: 1)
            
        } else if item.discount != 0 {
            self.specialOffer.text = "  -\(item.discount) %  "
            self.specialOffer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0, blue: 0, alpha: 1)
        } else {
            self.specialOffer.text = .none
        }
        
        // image downloading
        var str = item.image
                let range = str.index(str.startIndex, offsetBy: 8)..<str.index(str.startIndex, offsetBy: 17)
                str.removeSubrange(range)
        itemImage.sd_setImage(with: URL(string: str),
                              placeholderImage: UIImage(systemName: "photo"),
                              options: .continueInBackground,
                              completed: nil)
        
        // tag
        
        if item.tag?[self.indexpath.row].text != nil {
        self.tagLbl.text = item.tag?[self.indexpath.row].text
            let tagColor = item.tag?[self.indexpath.row].bgColor
        self.tagLbl.textColor = UIColor(hex: tagColor ?? "#FFFFFF" )
            self.tagPoint.backgroundColor = UIColor(hex: tagColor ?? "#FFFFFF")
            self.tagPoint.layer.cornerRadius = tagPoint.frame.height / 2
        }  else {
            
            self.tagPoint.backgroundColor = .white
            self.tagLbl.text = .none
        }
        // userdefaults
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

// extension for data formatting
extension Formatter {
    static let withSeperator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeperator: String { Formatter.withSeperator.string(for: self) ?? ""}
}


// extension to convert hex to rgb
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
