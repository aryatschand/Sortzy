//
//  HistoryTVC.swift
//  ProfHacks iOS
//
//  Created by Arya Tschand on 2/29/20.
//  Copyright © 2020 aryatschand. All rights reserved.
//

import UIKit

class HistoryTVC: UITableViewController {

    func refresh() {
        getLeader(value2: "sup")
    }
    
    @IBAction func Reload(_ sender: Any) {
        userArray = []
        refresh()
    }
    
    
    var userArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userArray = []
        refresh()
    }
    
    func getLeader(value2: String) {
        printMessagesForUser(parameters: value2) {
            (returnval, error) in
            if (returnval)!
            {
                DispatchQueue.main.async {

                    self.tableView.reloadData()
                }
            } else {
                print(error)
            }
        }
        DispatchQueue.main.async { // Correct
        }
    }
    
    func printMessagesForUser(parameters: String, CompletionHandler: @escaping (Bool?, Error?) -> Void){
        let json = [parameters]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            
            let url = NSURL(string: "https://7c5a521b.ngrok.io/iphone/history")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "Get"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if let returned = String(data: data!, encoding: .utf8) {
                    print(returned)
                    var newret: [String] = returned.components(separatedBy: ",")
                    for x in newret{
                        self.userArray.append(x)
                    }
                    CompletionHandler(true,nil)
                    
                    //self.Severity.text = "hello"
                } else {
                }
                
                //self.Severity.text = "test"
                
            }
            task.resume()
        } catch {
            
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "row", for: indexPath)
        cell.textLabel?.text = userArray[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "click" {
            let ImageVC = segue.destination as! ImageVC
            var selectedIndexPath = tableView.indexPathForSelectedRow
            var rowname: String = userArray[selectedIndexPath!.row]
            var splitArr: [String] = rowname.components(separatedBy: " - ")
            ImageVC.date = splitArr[0]
        }
    }

}
