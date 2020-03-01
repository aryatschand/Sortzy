//
//  TrashVC.swift
//  ProfHacks iOS
//
//  Created by Arya Tschand on 2/29/20.
//  Copyright © 2020 aryatschand. All rights reserved.
//

import UIKit

class TrashVC: UIViewController {
    
    @IBOutlet weak var TrashFull: UILabel!
    @IBOutlet weak var TrashSlider: UIProgressView!
    
    
    @IBOutlet weak var RecycleFull: UILabel!
    @IBOutlet weak var RecycleSlider: UIProgressView!
    
    @IBAction func Refresh(_ sender: Any) {
        refresh()
    }
    
    func refresh() {
        getStorage(value2: "sup")
    }
    
    var trash: Int = 100
    var recycle: Int = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    func getStorage(value2: String) {
        printMessagesForUser(parameters: value2) {
            (returnval, error) in
            if (returnval)!
            {
                DispatchQueue.main.async {

                    self.TrashFull.text = String(self.trash) + "% Full"
                    self.TrashSlider.setProgress(Float(self.trash)/100.0, animated: true)
                    self.RecycleFull.text = String(self.recycle) + "% Full"
                    self.RecycleSlider.setProgress(Float(self.recycle)/100.0, animated: true)
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
            
            
            let url = NSURL(string: "https://1b0d329c.ngrok.io/iphone/storage")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "Get"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if let returned = String(data: data!, encoding: .utf8) {
                    print(returned)
                    var newret: [String] = returned.components(separatedBy: ",")
                    print(newret)
                    self.trash = Int(newret[0])!
                    self.recycle = Int(newret[1])!
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
