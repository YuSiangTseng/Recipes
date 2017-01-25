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
    var searchBars: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 230, height: 20))
    var searchSmoothiesDataSource: SearchSmoothiesTableViewDataSource?
    
    //MARK:- view life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
    }
    
    //MARK:- set up views
    
    func setUpSearchBar() {
        searchBars.delegate = self
        searchBars.barTintColor = UIColor.white
        UITextField.appearance(whenContainedInInstancesOf: [type(of: searchBars)]).tintColor = UIColor.gray
        let leftNavBarButton = UIBarButtonItem(customView: searchBars)
        navigationItem.rightBarButtonItem = leftNavBarButton
    }
    
    func setUpTableView(drinkStore: DrinkStore) {
        searchSmoothiesDataSource = SearchSmoothiesTableViewDataSource(drinkStore: drinkStore)
        tableView.dataSource = searchSmoothiesDataSource
        tableView.delegate = self
        tableView.rowHeight = 160
    }
    
    //MARK:- segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSearchSmoothieRecipes" {
            showSearchSmoothieRecipe(segue: segue)
        }
    }
    
    func showSearchSmoothieRecipe(segue: UIStoryboardSegue) {
        if let row = tableView.indexPathForSelectedRow?.row{
            let smoothie = drinkStore?.searchSmoothies[row]
            let destinationVC = segue.destination as! SmoothieRecipesViewController
            destinationVC.drinkStore = drinkStore
            destinationVC.smoothie = smoothie
        }
    }
    
    //MARK:- search bars delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchSmoothies()
    }
    
    func searchSmoothies() {
        guard let allSmoothies = drinkStore?.allSmoothies,
            let searchSmoothie = searchBars.text else {
                return
        }
        
        drinkStore?.searchSmoothies.removeAll()
        searchBars.resignFirstResponder()
        
        let searchSmoothies = allSmoothies.filter() {
            return $0.label.lowercased().contains(searchSmoothie.lowercased())
        }
        
        if searchSmoothies.isEmpty {
            self.tableView.reloadData()
        }
        
        for (i, smoothie) in searchSmoothies.enumerated() {
            refreshControl?.beginRefreshing()
            drinkStore?.fetchSmoothiePhoto(smoothie: smoothie, completion: { (result) in
                self.drinkStore?.addSmoothiesToSearchResult(smoothie: smoothie)
                if i == searchSmoothies.count - 1 {
                    self.refreshControl?.endRefreshing()
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
    
    //MARK:- SrollviewDelegate
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        refreshControl = nil
    }
    
    //MARK:- TableviewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.frame.origin.x = 50.0
        cell.alpha = 0.5
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: .curveEaseIn, animations: {
            cell.frame.origin.x = 0.0
            cell.alpha = 1
        }, completion: nil)
    }

}
