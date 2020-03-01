//
//  OptionsTVC.swift
//  ProfHacks iOS
//
//  Created by Arya Tschand on 2/29/20.
//  Copyright © 2020 aryatschand. All rights reserved.
//

import UIKit

class OptionsTVC: UITableViewController {

    var display:[String] = ["Trash Storage", "User Statistics", "Leaderboard", "History"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "row", for: indexPath)
        cell.textLabel?.text = display[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.performSegue(withIdentifier: "trash", sender: self)
        }
        if indexPath.row == 1{
            self.performSegue(withIdentifier: "statistics", sender: self)
        }
        if indexPath.row == 2{
            self.performSegue(withIdentifier: "leaderboard", sender: self)
        }
        if indexPath.row == 3{
            self.performSegue(withIdentifier: "history", sender: self)
        }
    }


}
