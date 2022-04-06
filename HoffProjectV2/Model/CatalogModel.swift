//
//  CatalogModel.swift
//  HoffProjectV2
//
//  Created by Наида Мамаева on 02.04.2022.
//

import Foundation

struct Catalog: Codable {
    var totalCount: Int
    var items: [Items]
    var relatedCategories: [RelatedCategories]
    var categoryName: String
    var categoryUrl: String
   
    struct Items: Codable {
        var id: String
        var name: String
        var image: String
        var prices: Price
        var discount: Int
        var isBestPrice: Bool
        var tag: [Tags]? 
        var isFavorite: Bool
        var articul: String
        var rating: Double
        var numberOfReviews: String
        var in_stock: Int
        var yellow: Bool
        var statusText: String
        var isAvailable: Bool
        var categoryId: String
        var categoryTitle: String
        
        struct Tags: Codable {
            var text: String? = ""
            var textColor: String? = ""
            var bgColor: String? = ""
        }
    }
    struct Price: Codable {
        var new: Int
        var old: Int
    }
    
    struct RelatedCategories: Codable {
        var name: String
        var id: String

    }
    

}





