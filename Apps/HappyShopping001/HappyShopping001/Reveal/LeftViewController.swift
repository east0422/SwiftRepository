//
//  LeftViewController.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-22.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var dataList = ["111", "222", "333", "444", "555"]
    lazy var tabView: UITableView = {
        var tabV = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: UITableView.Style.plain)
        tabV.dataSource = self
        tabV.delegate = self
        return tabV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.red;
        self.navigationItem.title = "个人中心"
        
        self.view.addSubview(self.tabView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tabView.dequeueReusableCell(withIdentifier: "hsCellIdentifier")
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "hsCellIdentifier")
        }
        cell!.textLabel!.text = self.dataList[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc: UIViewController? = nil
        switch indexPath.row {
            case 0:
                vc = UIViewController.init()
                break
            default:
                vc = UIViewController.init()
                break
        }
        if (self.revealViewController() != nil && vc != nil) {
            self.revealViewController()?.pushFrontViewController(vc, animated: true)
        }
    }
}
