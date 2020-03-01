//
//  StatisticsVC.swift
//  ProfHacks iOS
//
//  Created by Arya Tschand on 2/29/20.
//  Copyright © 2020 aryatschand. All rights reserved.
//

import UIKit

class StatisticsVC: UIViewController {
    
    @IBOutlet weak var TrashAmt: UILabel!
    
    @IBOutlet weak var RecycleAmt: UILabel!
    
    @IBOutlet weak var Percentage: UILabel!
    
    @IBOutlet weak var PercentageSlide: UIProgressView!
    
    @IBOutlet weak var LinkOutlet: UIButton!
    
    @IBAction func Link(_ sender: Any) {
        if let url = NSURL(string: "https://www.treehugger.com/htgg/how-to-go-green-recycling.html"){
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    
    @IBAction func Refresh(_ sender: Any) {
        refresh()
    }
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
    }
    
    func refresh() {
        getStorage(value2: "sup")
    }
    
    var trash: Int = 100
    var recycle: Int = 100
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    func getStorage(value2: String) {
        printMessagesForUser(parameters: value2) {
            (returnval, error) in
            if (returnval)!
            {
                DispatchQueue.main.async {
                    if Int(self.trash) == 0 && Int(self.recycle) == 0{
                        self.Percentage.text = "0%"
                    } else {
                        self.Percentage.text = String(round(Float(self.recycle)/Float(self.trash + self.recycle) * 100.0)) + "%"
                    }
                    self.TrashAmt.text = String(self.trash)
                    self.PercentageSlide.setProgress(Float(self.recycle)/Float(self.trash + self.recycle), animated: true)
                    self.RecycleAmt.text = String(self.recycle)
                    if Float(self.recycle)/Float(self.trash + self.recycle) < 0.5{
                        self.LinkOutlet.isEnabled = true
                        self.LinkOutlet.isHidden = false
                    } else{
                        self.LinkOutlet.isEnabled = false
                        self.LinkOutlet.isHidden = true
                    }

                    
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
            
            
            let url = NSURL(string: "https://7c5a521b.ngrok.io/iphone/stats")!
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
