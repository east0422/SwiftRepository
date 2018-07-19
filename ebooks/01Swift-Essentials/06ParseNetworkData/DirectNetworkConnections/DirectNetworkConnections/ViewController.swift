//
//  ViewController.swift
//  DirectNetworkConnections
//
//  Created by dfang on 2018-7-27.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var items = [
        ("First", "A first item"),
        ("Second", "A second item"),
        ]
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    init() {
        super.init(style: UITableViewStyle.plain)
    }
    
    override func viewDidLoad() {
        DispatchQueue.global().async {
            let repo = RemoteGitRepository(host: "github.com", repo: "/alblue/com.packtpub.swift.essentials.git")
            // way of forcing true without compiler warnings of unused code
            let async = arc4random() >= 0
            if async {
                repo.lsRemoteAsync() { (ref:String,hash:String) in
                    print("ref:\(ref), hash:\(hash)")
                    self.items.append((ref, hash))
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } else {
                print("sync")
                for (ref,hash) in repo.lsRemote() {
                    print("ref:\(ref), hash:\(hash)")
                    self.items.append((ref, hash))
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (title,subtitle) = items[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "prototypeCell")
        }
        
        cell!.textLabel?.text = title
        cell!.detailTextLabel?.text = subtitle
        
        return cell!
    }
}

