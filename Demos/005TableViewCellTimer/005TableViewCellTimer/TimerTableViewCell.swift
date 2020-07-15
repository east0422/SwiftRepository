//
//  TimerTableViewCell.swift
//  005TableViewCellTimer
//
//  Created by dfang on 2020-7-15.
//  Copyright © 2020 east. All rights reserved.
//

import UIKit

let TimerCellNotification = "NotificationTimerCell"

class TimerTableViewCell: UITableViewCell {
    
    lazy var titleLabel = { () -> UILabel in
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var timeLabel = { () -> UILabel in
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.blue
        return label
    }()
    
    // 结束时间
    private var _endDate:Date?
    var endDate:Date? {
        get {
            return _endDate
        }
        set {
            _endDate = newValue
            guard (newValue != nil) else { // 为nil时返回不做后续操作
                return
            }
            timeLabel.text = TimeUitl.compareCurrentTime(date: newValue!)
        }
    }
    
    override func awakeFromNib() { // 从nib加载初始化
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTimeLabel), name: NSNotification.Name(rawValue: TimerCellNotification), object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let halfWidth = contentView.frame.size.width/2
        titleLabel.frame = CGRect.init(x: 0, y: 0, width: halfWidth, height: 50)
        timeLabel.frame = CGRect.init(x: halfWidth, y: 0, width: halfWidth, height: 50)
    }
    
    @objc func updateTimeLabel() {
        guard endDate != nil else {
            return
        }
        
        DispatchQueue.main.async { // 在主线程中更新UI
            self.timeLabel.text = TimeUitl.compareCurrentTime(date:self.endDate!)
        }
    }
    
    deinit {
        print("TimerTableViewCell deinit")
        NotificationCenter.default.removeObserver(self)
    }
}
