//
//  FirstViewController.swift
//  005TableViewCellTimer
//
//  Created by dfang on 2020-7-14.
//  Copyright © 2020 east. All rights reserved.
//

import UIKit

typealias updateCellTimeFunc = () -> Void

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 初始化时间数组
    lazy var timeList = TimeUitl.createTimeListWithCount(count: 20)
    
    // cell更新倒计时操作字典(key为cell对应indexPath.row, value为更新其倒计时操作)
    var updateCellTimeDic:[Int:updateCellTimeFunc] = [Int:updateCellTimeFunc]()
    // 定时器，用于cell倒计时
    var timer:Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        
        // 使用weak self打破循环引用
        timer = Timer.init(timeInterval: 1.0, repeats: true, block: {[weak self] _ in
            if (self != nil) {
                for (_, updateFunc) in self!.updateCellTimeDic {
                    updateFunc()
                }
            }
        })
        
        // 为定时器增加mode
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    }

    // MARK: --- UITableViewDataSource 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdKey = "firstCellIdKey"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdKey)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdKey)
            cell?.detailTextLabel?.textColor = UIColor.red
        }
        
        cell?.textLabel?.text = "time-\(indexPath.row)"
        cell?.detailTextLabel?.text = TimeUitl.compareCurrentTime(date:timeList[indexPath.row])
        
        if ((updateCellTimeDic[indexPath.row]) == nil) {
            updateCellTimeDic[indexPath.row] = {[weak self] () in
                DispatchQueue.global().async { // 计算如果比较耗时可以放到子线程中
                    let nowStr = TimeUitl.compareCurrentTime(date: self?.timeList[indexPath.row] ?? Date.init())
                    DispatchQueue.main.async { // 回到主线程更新UI
                        cell?.detailTextLabel?.text = nowStr
                    }
                }
            }
        }
        
        return cell!
    }
    
    deinit {
        timer.invalidate()
    }
}

