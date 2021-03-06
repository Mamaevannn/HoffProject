//
//  Sorting options.swift
//  HoffProjectV2
//
//  Created by Наида Мамаева on 05.04.2022.
//

import Foundation

protocol CatalofProtocol: AnyObject {
    var sortBy: SortBy { get set}
    var sortType: SortType {get set}
}


enum SortBy: String {
    case price = "price"
    case popular = "popular"
    case discount = "discount"
}

enum SortType: String {
    case asc = "asc" // по возрастанию
    case desc = "desc" // по убыванию
}
