//
//  Presenter.swift
//  HoffProjectV2
//
//  Created by Наида Мамаева on 03.04.2022.
//

import Foundation
import UIKit

//перечисляем все функции, которые будет вызывать во вьюеконтроллере
protocol CatalogPresenterProtocol: AnyObject {
    func startPagination(collectionView: UICollectionView)
}


class CatalogPresenter: CatalogPresenterProtocol {
    
    var isLoading = false
    var offset = 0
    var limit = 20
    var pageNumber = 0
    let service = NetworkService()
    
    func startPagination(collectionView: UICollectionView) {
        if ((collectionView.contentOffset.y + collectionView.frame.size.height) >= collectionView.contentSize.height) {
            if !isLoading {
                isLoading = true
                DispatchQueue.global().async {
                    // fake background loading task for a second
                    sleep(1)
                    self.pageNumber = self.pageNumber + 1
                    self.limit = self.limit + 20
                    self.offset = self.limit * self.pageNumber
                    self.service.getData(limit: "\(self.limit)", offset: "\(self.offset)")
                    
                }
            }
        }
    }
    
var view: ViewControllerInput?
    init(view: ViewControllerInput) {
        self.view = view
    }
    
 
    
}



protocol ViewControllerInput {
    func succesObtainProducts(products: Catalog)
    func failureObtainProducts(error: String)
}


