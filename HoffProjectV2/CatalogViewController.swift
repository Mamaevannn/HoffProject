//
//  CatalogViewController.swift
//  HoffProjectV2
//
//  Created by Наида Мамаева on 02.04.2022.
//

import UIKit

class CatalogViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: Presenter?
    var catalogItem: [Catalog.Items] = []
   

    let service = NetworkService()
    var catalog: Catalog?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nibBundle), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        sortByPopular()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        self.collectionView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)

    }
    
    private func sortByPopular() {
//        presenter = Presenter(view: self as ViewControllerInput)
//         presenter?.loadCatalog()
        service.getData(categoryId: "320", sortBy: "price", sortType: "asc", limit: "20", offset: "0")
        service.completionHandler { [weak self] (items, status, message) in
            if status {
                guard let self = self else {return}
                guard let _items = items?.items else {return}
            self.catalogItem = _items
                self.collectionView.reloadData()
            }
        }
     }
    
    private func sortByPriceAsc() {

        service.getData(categoryId: "320", sortBy: "price", sortType: "asc", limit: "20", offset: "0")
        service.completionHandler { [weak self] (items, status, message) in
            if status {
                guard let self = self else {return}
                guard let _items = items?.items else {return}
            self.catalogItem = _items
                self.collectionView.reloadData()
            }
        }
     }
    
    private func sortByPriceDesc() {

        service.getData(categoryId: "320", sortBy: "price", sortType: "desc", limit: "100", offset: "0")
        service.completionHandler { [weak self] (items, status, message) in
            if status {
                guard let self = self else {return}
                guard let _items = items?.items else {return}
            self.catalogItem = _items
                self.collectionView.reloadData()
            }
        }
     }
    
    private func sortByDiscount() {

        service.getData(categoryId: "320", sortBy: "discount", sortType: "desc", limit: "20", offset: "0")
        service.completionHandler { [weak self] (items, status, message) in
            if status {
                guard let self = self else {return}
                guard let _items = items?.items else {return}
            self.catalogItem = _items
                self.collectionView.reloadData()
            }
        }
     }
    
    
    @IBOutlet weak var sortButton: UIButton!
    @IBAction func didTap(_ sender: UIButton) {
        showSortOptions()
    }
    
    func showSortOptions() {
        let actionSheet = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "По популярности", style: .default, handler: { action in
            self.sortButton.titleLabel?.text = "По популярности"
            self.sortByPopular()
        }))
        actionSheet.addAction(UIAlertAction(title: "По возрастанию цены", style: .default, handler: { action in
            // insert action
            self.sortButton.titleLabel?.text = "По возрастанию цены"
            self.sortByPriceAsc()
        }))
        actionSheet.addAction(UIAlertAction(title: "По убыванию цены", style: .default, handler: { action in
            // insert action
            self.sortButton.titleLabel?.text = "По убыванию цены"
            self.sortByPriceDesc()
        }))
        actionSheet.addAction(UIAlertAction(title: "По скидкам", style: .default, handler: { action in
            // insert action
            self.sortButton.titleLabel?.text = "По скидкам"
            self.sortByDiscount()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
           
        }))
        present(actionSheet, animated: true)
    }
    
   
}

extension CatalogViewController: UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell {
            let item = catalogItem[indexPath.row]
            cell.setupCell(item: item)
            cell.backgroundColor = .white
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowOpacity = 1
            cell.layer.shadowRadius = 6
            cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 4
            cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
            cell.layer.masksToBounds = false
            
        return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catalogItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2 - 20, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//extension CatalogViewController: ViewControllerInput {
//    func succesObtainProducts(products: Catalog) {
//        self.catalog = products
//        self.collectionView.reloadData()
//    }
//
//    func failureObtainProducts(error: String) {
//
//    }
//
//
//}
