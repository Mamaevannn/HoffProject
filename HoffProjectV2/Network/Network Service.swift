//
//  Network Service.swift
//  HoffProjectV2
//
//  Created by Наида Мамаева on 02.04.2022.
//

import Foundation
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
     init() {
    }
    typealias itemCallBack = (_ items: Catalog?, _ status: Bool, _ message: String) -> Void
    var callBack: itemCallBack?
    
     func getData(categoryId: String = "1255", sortBy: String = "popular", sortType: String = "desc", limit: String = "20", offset: String = "0") {

       var urlComponents = URLComponents()
       urlComponents.scheme = "https"
       urlComponents.host = "dev-re-1.hoff.ru"
       urlComponents.path = "/api/v2/get_products_new"
       urlComponents.queryItems = [
           URLQueryItem(name: "category_id", value: categoryId),
           URLQueryItem(name: "sort_by", value: sortBy),
           URLQueryItem(name: "sort_type", value: sortType),
           URLQueryItem(name: "limit", value: limit),
           URLQueryItem(name: "offset", value: offset),
           URLQueryItem(name: "device_id", value: "3a7612bcc84813b5"),
           URLQueryItem(name: "isAndroid", value: "false"),
           URLQueryItem(name: "app_version", value: "1.8.16"),
           URLQueryItem(name: "location", value: "19")
//            URLQueryItem(name: "xhoff", value: "36f40b3d665cdb9435904796172dde5e3f13aa8a%3A4630")
       ]
       
//        print(urlComponents.url!)
       
        AF.request(urlComponents).response { response in
            guard let data = response.data else {
                self.callBack?(nil, false, "")
                return}
            do{
             let response = try JSONDecoder().decode(Catalog.self, from: data)
                self.callBack?(response, true, "")
//                print(response)
            }
            catch {
                self.callBack?(nil, false, error.localizedDescription)
                print(error)
            }
        }
   }
    
    func completionHandler(callBack: @escaping itemCallBack) {
        self.callBack = callBack
    }

}

