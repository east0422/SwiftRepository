//
//  LoginViewController.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-24.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit
import Toast_Swift

class LoginViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 数字键盘顶部显示自定义完成按钮
        usernameTxt.showToolBar()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard)))
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        let account = self.usernameTxt.text
        var message: String? = nil
        if (account == nil || account!.count == 0) {
            message = "输入为空，请输入您的登录账号"
        } else if (account!.count < 7 || account!.count > 11) {
            message = "请输入7到11位登录账号"
        }
        if (message != nil) {
            self.view.makeToast(message, duration: 3.0, position: ToastPosition.center)
            return
        }
        
        sender.isEnabled = false
        
        Api.login(account: account!) { (resp, error) in
            sender.isEnabled = true
            if (error == nil) { // 登录成功
                let userInfo = resp?.value(forKey: "data") as? NSDictionary
                if (userInfo != nil && (userInfo?.value(forKey: "exesis") as? Int != 1)) {
                    let errorMsg = "对不起，登录失败:" + (userInfo?.value(forKey: "msg") as? String ?? "")
                    self.view.makeToast(errorMsg, position: ToastPosition.center)
                } else {
                    UserInfoModel.saveUserInfo(userInfo: UserInfoModel.init(dict: userInfo!))
                    self.present(RootViewController(), animated: true, completion: nil)
                }
            } else { // 登录失败
                self.view.makeToast(error?.localizedDescription, duration: 3.0, position: ToastPosition.center)
            }
        }
    }
    
    
    // UITextFieldDelegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // 关闭键盘
    @objc func dismissKeyboard() {
        usernameTxt.resignFirstResponder()
    }
}
