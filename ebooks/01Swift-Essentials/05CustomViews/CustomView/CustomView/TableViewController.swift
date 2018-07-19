//
//  TableViewController.swift
//  CustomView
//
//  Created by dfang on 2018-7-24.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    lazy var items = [
        ("First", "A first item"),
        ("Second", "A second item")
        ]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib.init(nibName: "CounterView", bundle: nil)
        let objects = xib.instantiate(withOwner: self, options: nil)
        let counterView = objects.first as? UIView
        tableView.tableHeaderView = counterView
//        tableView.tableFooterView = xib.instantiate(withOwner: self, options: nil).first as? UIView
        let footer = UITableViewHeaderFooterView()
        footer.contentView.addSubview(TwoLabels(frame:CGRect.zero))
        tableView.tableFooterView = footer
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (title,subtitle) = items[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell")
        if (cell == nil) {
            cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcell")
            if (cell == nil) {
                cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "tableviewcell")
            }
            cell?.textLabel?.text = title
            cell?.detailTextLabel?.text = subtitle
        } else {
            let titleLabel = cell!.viewWithTag(1) as! UILabel
            let subtitleLabel = cell!.viewWithTag(2) as! UILabel
            titleLabel.text = title
            subtitleLabel.text = subtitle
        }
        
        return cell!
    }
}
