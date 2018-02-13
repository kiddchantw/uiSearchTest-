//
//  TableViewControllerOne.swift
//  uiSearchTest
//
//  Created by kiddchantw on 2018/1/22.
//  Copyright © 2018年 kiddchantw. All rights reserved.
//

import UIKit

class TableViewControllerOne: UITableViewController,UISearchResultsUpdating {
    
    var songs =   ["Inro+溫暖而綿長的，餘燼","擱淺的人","在你死後才想起曾經答應陪你去散步","你好","一隅之見","五里霧中","犬的視線","16分鐘聽完康士坦專輯","Eureka!Eureka!"]
    var songs2 = ["7:46","4:32","8:18","4:51","4:55","3:20","6:06","16:02","4:00"]

    
    var searchSongs = [String]()
    
    
    
   
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchString = searchController.searchBar.text else {
            return
        }
        // 輸入框沒有輸入文字時
        if searchString.characters.count == 0 {
            tableView.reloadData()
            return
        }
        let filtered:Array<String> = songs.filter { $0.contains(searchString) }
        print("filtered.count \(filtered.count)")
        searchSongs = filtered
        tableView.reloadData()
    }
    

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        songs =   ["Inro+溫暖而綿長的，餘燼","擱淺的人","在你死後才想起曾經答應陪你去散步","你好","一隅之見","五里霧中","犬的視線","16分鐘聽完康士坦專輯","Eureka!Eureka!"]
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if navigationItem.searchController?.isActive == true {
            return searchSongs.count
        } else {
            return songs.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if navigationItem.searchController?.isActive == true {
            cell.textLabel?.text = searchSongs[indexPath.row]
        } else {
            cell.textLabel?.text = songs[indexPath.row]
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if navigationItem.searchController?.isActive == true {
            print(searchSongs[indexPath.row])
        } else {
            print(songs[indexPath.row])
        }
    }


}
