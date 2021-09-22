//
//  MainTVC.swift
//  iTunesTest
//
//  Created by 陳鋐洋 on 2021/9/22.
//

import UIKit

class MainTVC: UITableViewController {
    
    var items = [StoreItem]()
    let segmentTitleArray = ["movie", "music", "software", "ebook"]

 
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func segmented(_ sender: Any) {
        getItems()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell

        let item = items[indexPath.row]
        cell.tvTitle.text = item.name
        cell.tvSubTitle.text = item.artist
        
        // fetchImage
        StoreItemController.shard.fetchImage(from: item.artworkURL) { image in
            
            if let image = image {
                DispatchQueue.main.async {
                    cell.imgView.image = image
                }
            }
        }

        return cell
    }


}
extension MainTVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        getItems()
        searchBar.resignFirstResponder()
    }
    
}

extension MainTVC {
    
    func getItems (){
        
        items = []
        tableView.reloadData()
        
        let mediaType = segmentTitleArray[segmentedControl.selectedSegmentIndex]
        
        let searchTerm = searchBar.text ?? ""
        
        if !searchTerm.isEmpty {
            StoreItemController.shard.fetchItems(term: searchTerm, media: mediaType, lang: "en_us", limit: 20) { items in
                
                if let items = items {
                    self.items = items
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
    }

}
