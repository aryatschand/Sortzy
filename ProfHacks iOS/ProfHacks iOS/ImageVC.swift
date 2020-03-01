//
//  ImageVC.swift
//  ProfHacks iOS
//
//  Created by Arya Tschand on 2/29/20.
//  Copyright © 2020 aryatschand. All rights reserved.
//

import UIKit

class ImageVC: UIViewController {
    
    var date: String = ""
    
    var b64: String = ""

    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    func refresh() {
        getStorage(value2: date)
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
                    if let decodedData = Data(base64Encoded: self.b64, options: .ignoreUnknownCharacters) {
                        let decodedimage = UIImage(data: decodedData)
                        self.image.image = decodedimage as! UIImage
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
            
            
            let url = NSURL(string: "https://7c5a521b.ngrok.io/iphone/history/image?date=" + parameters)!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "Get"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if let returned = String(data: data!, encoding: .utf8) {
                    self.b64 = returned
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
