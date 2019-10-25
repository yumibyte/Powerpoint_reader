//
//  TableViewController.swift
//  Powerpoint_readerc
//
//  Created by Ashley Raigosa on 10/24/19.
//  Copyright © 2019 Ashley Raigosa. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let flashCardArray = ["dog", "2"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - TableView Datasource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return flashCardArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        
        
            
        
    }

}
