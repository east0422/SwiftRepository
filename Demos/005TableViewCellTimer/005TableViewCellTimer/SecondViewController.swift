//
//  SecondViewController.swift
//  005TableViewCellTimer
//
//  Created by dfang on 2020-7-14.
//  Copyright © 2020 east. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    // 表视图
    lazy var tableView:UITableView = UITableView()
    // 填充表视图数据数组
    lazy var dataList = TimeUitl.createTimeListWithCount(count: 30)
    
    // 定时器
    let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        // 立即开始，每秒循环一次
        timer.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(1))
        // 添加处理事件
        timer.setEventHandler {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: TimerCellNotification), object: nil)
        }
        // 启动
        timer.resume()
    }
    
    deinit {
        timer.cancel()
    }
}

// MARK: 扩展初始化UI
extension SecondViewController {
    func initUI() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self

        view.backgroundColor = UIColor.lightText
        view.addSubview(tableView)
    }
}

// MARK: 扩展遵循表视图协议
extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdKey = "secondCellIdKey"
        var cell:TimerTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdKey) as? TimerTableViewCell
        if cell == nil {
            cell = TimerTableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdKey)
        }

        cell?.titleLabel.text = "index-\(indexPath.row)"
        cell?.endDate = dataList[indexPath.row]
        
        return cell!
    }
}

