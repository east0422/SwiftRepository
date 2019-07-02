//
//  RegisterViewController.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-24.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit
import Toast_Swift

class RegisterViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var reguserTxt: UITextField!
    @IBOutlet weak var reginviterTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reguserTxt.showToolBar()
        reginviterTxt.showToolBar()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard)))
    }
    
    @IBAction func regClicked(_ sender: UIButton) {
        let regAccount = self.reguserTxt.text
        let regInviter = self.reginviterTxt.text
        
        var message:String? = nil
        if (regAccount == nil || regAccount?.count == 0) {
            message = "注册账号为空，请输入7到11位数字注册账号"
        }
        
        // 邀请者账号为7到11为数字，没有可不填
        if (regInviter != nil && regInviter!.count > 0 && (regInviter!.count < 7) || regInviter!.count > 11){
            message = "邀请者账号为7到11位数字，没有可不填写"
        }
        
        if (message != nil) {
            self.view.makeToast(message, duration: 3.0, position: ToastPosition.center)
            return
        }
        
        sender.isEnabled = false
        Api.register(regaccount: regAccount!, inviteaccount: regInviter) { (resp, error) in
            sender.isEnabled = true
            if (error == nil) { // 登录成功
                let userInfo = resp?.value(forKey: "data") as? NSDictionary
                if (userInfo != nil && (userInfo?.value(forKey: "exesis") as? Int != 1)) {
                    let errorMsg = "对不起，注册失败:" + (userInfo?.value(forKey: "msg") as? String ?? "")
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
    
    // UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // 关闭键盘
    @objc func dismissKeyboard() {
        reguserTxt.resignFirstResponder()
        reginviterTxt.resignFirstResponder()
    }
}
