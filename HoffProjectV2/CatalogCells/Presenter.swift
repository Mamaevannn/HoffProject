//
//  Presenter.swift
//  HoffProjectV2
//
//  Created by Наида Мамаева on 03.04.2022.
//

import Foundation

class Presenter {
var view: ViewControllerInput?
    init(view: ViewControllerInput) {
        self.view = view
    }
    
//    let service = NetworkService()
    
//    func loadCatalog() {
//        
//        service.getData(categoryId: "320", sortBy: "popular", sortType: "desc", limit: "20", offset: "0") { products in
//            self.view?.succesObtainProducts(products: products)
//        } failureCompletion: { error in
//            self.view?.failureObtainProducts(error: error)
//        }
//    }
}



protocol ViewControllerInput {
    func succesObtainProducts(products: Catalog)
    func failureObtainProducts(error: String)
}


