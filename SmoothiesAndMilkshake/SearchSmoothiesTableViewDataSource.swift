//
//  SearchSmoothiesTableViewDataSource.swift
//  SmoothiesAndMilkshake
//
//  Created by Chris Tseng on 20/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import UIKit

class SearchSmoothiesTableViewDataSource: NSObject, UITableViewDataSource {
    
    var drinkStore: DrinkStore
    
    init(drinkStore: DrinkStore) {
        self.drinkStore = drinkStore
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinkStore.searchSmoothies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchSmoothiesCell") as!  SearchSmoothiesTableViewCell
        cell.smoothieImageView.image = drinkStore.searchSmoothies[indexPath.row].image
        cell.smoothieName.text = drinkStore.searchSmoothies[indexPath.row].label
    
        return cell
    }
    
    
}
