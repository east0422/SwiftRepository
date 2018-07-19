//
//  SampleTableViewController.swift
//  ParseNetworkData
//
//  Created by dfang on 2018-7-25.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class SampleTableViewController: UITableViewController {
    
    var items:[(String, String)] = [("first", "A first item")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initItems()
    }
    
    func initItems() {
        // parse json
        loadJsonData()
        // parse xml
        loadXmlData()
    }
    
    func loadJsonData() {
        let filePath = Bundle.main.path(forResource: "SampleTable", ofType: "json")
        let url = URL.init(fileURLWithPath: filePath!)
//        let url = URL.init(string: "faafa")! // test for error
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            switch (data, response, error) {
            case (_, _, let e) where e != nil:  // let e has the effect of let e = error in this case
                self.items.append(("Error", error!.localizedDescription))
            case (_, let resp as HTTPURLResponse, _) where resp.statusCode >= 400 && resp.statusCode < 500:
                self.items.append(("Client error \(resp.statusCode)", url.absoluteString))
            case (_, let resp as HTTPURLResponse, _) where resp.statusCode >= 500:
                self.items.append(("Server error \(resp.statusCode)", url.absoluteString))
            default:
//                let contents = String.init(data: data!, encoding: String.Encoding.utf8)!
//                self.items.append((url.absoluteString, contents))
                do {
                    if let dicts = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? Array<Dictionary<String, String>> {
                        for dict in dicts { // not nil
                            self.items.append((dict["title"]!, dict["content"]!))
                        }
                    } else { // nil
                        self.items.append(("Error", "Cannot parse json"))
                    }
                } catch {
                    print("parse error: \(error)")
                }
            } // end switch
            
             // if else
//            if (error == nil) {
//                if (url.absoluteString.hasPrefix("http")) {
//                    let httpResponse = response as! HTTPURLResponse
//                    let statusCode = httpResponse.statusCode
//                    if (statusCode >= 400  && statusCode < 500) { // 400...500 ~= httpResponse.statusCode
//                        self.items.append(("Client error \(statusCode)", url.absoluteString))
//                    } else if (statusCode >= 500) {
//                        self.items.append(("Server error \(statusCode)", url.absoluteString))
//                    } else {
//                        let contents = String.init(data: data!, encoding: String.Encoding.utf8)!
//                        self.items.append((url.absoluteString, contents))
//                    }
//                } else {
//                    let contents = String.init(data: data!, encoding: String.Encoding.utf8)!
//                    self.items.append((url.absoluteString, contents))
//                }
//            } else {
//                self.items.append(("Error", error!.localizedDescription))
//            }
            
            self.runOnUIThread(fn: self.tableView.reloadData)
//            self.runOnUIThread {
//                self.tableView.reloadData()
//            }
        } // end task
        task.resume()
    }
    
    func loadXmlData() {
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Items", ofType: "xml")!)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (data != nil) {
                self.items.append(contentsOf: ItemsParser.init(data: data!).items)
                self.runOnUIThread(fn: self.tableView.reloadData)
            }
        }.resume()
    }
    
    // execute fn on UI Thread
    func runOnUIThread(fn:@escaping () -> Void) {
        if Thread.isMainThread {
            fn()
        } else {
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                   fn()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")

        if (cell == nil) {
            cell = SampleTableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "reuseIdentifier")
        }
        
        let (title, detail) = items[indexPath.row]
        cell?.textLabel?.text = title
        cell?.detailTextLabel?.text = detail

        return cell!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
