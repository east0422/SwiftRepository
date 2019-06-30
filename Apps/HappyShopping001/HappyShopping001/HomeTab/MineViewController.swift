//
//  MineViewController.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-24.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let mineItems = [["基本资料"],
                     ["资料信息", "邀请列表", "余额信息", "我的订单", "我要提现"],
                     ["新人引导"]
                    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注册mineitemCell
        let mineItemCellNib = UINib(nibName: "MineItemCell", bundle: nil)
        tableView.register(mineItemCellNib, forCellReuseIdentifier: "mineitemcellid")
        
        // 添加底部退出登录按钮
        let exitButton = UIButton.init(frame: CGRect.init(x: (SCREEN_WIDTH - 260)/2, y: 0, width: 260, height: 40))
        exitButton.backgroundColor = UIColor.red
        exitButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        exitButton.setTitle("退出登录", for: UIControl.State.normal)
        // 圆角
        exitButton.layer.cornerRadius = 20
        exitButton.addTarget(self, action: #selector(exitClicked), for: UIControl.Event.touchUpInside)
        // 底部视图
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 60))
        footerView.addSubview(exitButton)
        tableView.tableFooterView = footerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mineItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mineItems[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 80
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0.00001
        } else {
            return 10.00001
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        if (indexPath.section == 0) { // 基本信息
            cell = self.tableView.dequeueReusableCell(withIdentifier: "mineitemcellid")
            cell?.selectionStyle = UITableViewCell.SelectionStyle.none
            let userInfo = UserInfoModel.fetchUserInfo()
//            (cell as! MineItemCell).avatarImageView.image = UIImage.init(named: "avatar")
            (cell as! MineItemCell).usernameLabel.text = userInfo?.mobile ?? "用户名"
            let sign = userInfo?.sign
            var nickname = "昵称"
            if (sign != nil) {
                nickname = "\(sign!)号服务器"
            }
            (cell as! MineItemCell).nicknameLabel.text = nickname
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "minitemdefaultcellid")
            if (cell == nil) {
                cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "minitemdefaultcellid")
                cell?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }
            cell?.textLabel?.text = mineItems[indexPath.section][indexPath.row]
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 跳转
        if (indexPath.section == 1) {
            let msg = ["资料", "邀请", "余额", "订单", "提现"][indexPath.row]
            Api.queryMsg(msg: msg) { (resp, error) in
                var resultMsg = "对不起，操作失败！"
                if (error != nil) {
                    resultMsg = error?.localizedDescription ?? "对不起，操作失败！"
                } else {
                    let respData = resp?.value(forKey: "data") as? NSDictionary
                    if (respData != nil) {
                        resultMsg = respData!.value(forKey: "msg") as! String
                    }
                }
            
                let detailVC = UIStoryboard.init(name: "QueryDetail", bundle: nil).instantiateViewController(withIdentifier: "QueryDetailStoryboardId") as! QueryDetailViewController
                detailVC.topTitle = msg
                detailVC.copyMsg = resultMsg
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            
        } else if (indexPath.section == 2) {
            let newbieGuideVC = UIStoryboard.init(name: "NewbieGuide", bundle: nil).instantiateViewController(withIdentifier: "NewbieGuideStoryboardId") as! NewbieGuideViewController
            self.navigationController?.pushViewController(newbieGuideVC, animated: true)
        }
    }
    
    // 退出方法
    @objc func exitClicked() {
        UserInfoModel.removeUserInfo()
        let loginVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginStoryboardId")
        let rootVC = UINavigationController.init(rootViewController: loginVC)
        self.present(rootVC, animated: true, completion: nil)
    }
}
