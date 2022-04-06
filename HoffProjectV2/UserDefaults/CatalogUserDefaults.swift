//
//  UserDefaults.swift
//  HoffProjectV2
//
//  Created by Наида Мамаева on 06.04.2022.
//

import Foundation

final class CatalogUserDefaults {
    static let shared = CatalogUserDefaults()
    
    private let favKey = "favorite_hoff"
    private var favItems: [Catalog.Items] = []
    
    private init() {
        guard let favData = UserDefaults.standard.data(forKey: favKey),
              let favFromDB = try? JSONDecoder().decode([Catalog.Items].self, from: favData)
        else {return}
        
        favItems.append(contentsOf: favFromDB)
    }
    
    // обновление данных
    
    private func synchronize() {
        guard let favItems = try? JSONEncoder().encode(favItems)
        else {return}
        
        UserDefaults.standard.set(favItems, forKey: favKey)
    }
    
    // MARK: - favorite
    
    // Проверка на нахождение в избранном
    
    func isFavorite(item: Catalog.Items) -> Bool {
        if (favItems.firstIndex(where: { $0.id == item.id}) != nil) {
            return true
        } else {
            return false
        
    }
    }
    
    func addOrRemoveFavorite(item: Catalog.Items) -> Bool {
        if let index = favItems.firstIndex(where: {$0.id == item.id}) {
            favItems.remove(at: index)
            
            //обновление данных юзерфалс
            synchronize()
            return false
        } else {
            favItems.append(item)
            synchronize()
            return true
        }
    }
}
