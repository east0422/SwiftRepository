//
//  TimeUitl.swift
//  005TableViewCellTimer
//
//  Created by dfang on 2020-7-14.
//  Copyright © 2020 east. All rights reserved.
//

import UIKit

class TimeUitl: NSObject {
    
    // 创建一个长度为count的时间数组
    class func createTimeListWithCount(count:Int) -> [Date] {
        var timeArr:[Date] = []
        // 当前时间
        let now = Date.init()
        for _ in 1...count {
            // 随机生成间距不超过30天的时间，获取某个X ~ N 之间的随机数 arc4random() % (N - X) + X
            timeArr.append(Date.init(timeInterval: TimeInterval(arc4random() % (3600 * 24 * 30)), since: now))
        }
        return timeArr;
    }
    // 当前时间相距date倒计时转换为字符串
    class func compareCurrentTime(date: Date) -> String {
        let seconds = Int(date.timeIntervalSinceNow)
        if (seconds <= 0) { // date早于当前日期和时间
            return "已结束"
        }

        // 天
        let days = seconds / (3600 * 24)
        // 小时
        let hours = (seconds % (3600 * 24)) / 3600
        // 分钟
        let minutes = (seconds % 3600) / 60
        // 秒
        let second = seconds % 60

        return String(format: "%02lu天 %02lu:%02lu:%02lu", days, hours, minutes, second)
    }
}
