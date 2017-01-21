//
//  SearchSmoothiesTableViewController.swift
//  SmoothiesAndMilkshake
//
//  Created by Chris Tseng on 20/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import UIKit

class SearchSmoothiesTableViewController: UITableViewController, UISearchBarDelegate {

    var drinkStore: DrinkStore? {
        didSet {
            setUpTableView(drinkStore: drinkStore!)
        }
    }
    var searchBars:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 230, height: 20))
    var searchSmoothiesDataSource: SearchSmoothiesTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBars.delegate = self
        let leftNavBarButton = UIBarButtonItem(customView: searchBars)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
    }
    
    func setUpTableView(drinkStore: DrinkStore) {
        searchSmoothiesDataSource = SearchSmoothiesTableViewDataSource(drinkStore: drinkStore)
        tableView.dataSource = searchSmoothiesDataSource
        tableView.delegate = self
        tableView.rowHeight = 160
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let allSmoothies = drinkStore?.allSmoothies,
        let searchSmoothie = searchBars.text else {
            return
        }
        drinkStore?.searchSmoothies.removeAll()
        searchBars.resignFirstResponder()
        let searchSmoothies = allSmoothies.filter() {
            if let label = $0.label?.lowercased() {
                if label.contains(searchSmoothie.lowercased()) {
                    return true
                }
            }
            return false
        }
        for (i, smoothie) in searchSmoothies.enumerated() {
            drinkStore?.fetchSmoothiePhoto(smoothie: smoothie, completion: { (result) in
                self.drinkStore?.addSmoothiesToSearchResult(smoothie: smoothie)
                if i == searchSmoothies.count - 1 {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBars.text = ""
        searchBars.showsCancelButton = false
        searchBars.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBars.showsCancelButton = true
    }

}
