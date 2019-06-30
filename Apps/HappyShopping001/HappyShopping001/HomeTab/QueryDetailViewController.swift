//
//  QueryDetailViewController.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-28.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit
import Toast_Swift

class QueryDetailViewController: BaseViewController {
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var btn: UIButton!
    var copyMsg: String? = nil
    var topTitle: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (topTitle != nil) {
            self.title = topTitle
            if (topTitle == "余额") {
                btn.setTitle("余额提取", for: UIControl.State.normal)
            }
        }
        
        resultTextView.text = copyMsg     
    }
    
    @IBAction func copyClicked(_ sender: Any) {
        if (btn.currentTitle == "余额提取") {
            Api.queryMsg(msg: "余额提取") { (resp, error) in
                var resultMsg = "对不起，操作失败！"
                if (error != nil) {
                    resultMsg = error?.localizedDescription ?? "对不起，操作失败！"
                } else {
                    let respData = resp?.value(forKey: "data") as? NSDictionary
                    if (respData != nil) {
                        resultMsg = respData!.value(forKey: "msg") as! String
                        if (resultMsg == "no-openid") {
                            let alertVC = UIAlertController.init(title: "未绑定收款账号，是否查看如何绑定？", message: "余额提取", preferredStyle: UIAlertController.Style.alert)
                            let okAction = UIAlertAction.init(title: "查看", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                                let guideVC = UIStoryboard.init(name: "Guide", bundle: nil).instantiateViewController(withIdentifier: "GuideStoryboardId") as! GuideViewController
                                guideVC.urlStr = "http://localhost/guide/?noCache=\(NSDate().timeIntervalSince1970)"
                                self.navigationController?.pushViewController(guideVC, animated: true)
                            })
                            alertVC.addAction(okAction)
                            let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: {(UIAlertAction) in
                                resultMsg = "对不起，您还未绑定收款账号，请先绑定账号再提现！"
                            })
                            alertVC.addAction(cancelAction)
                            
                            self.present(alertVC, animated: true, completion: nil)
                            
                            return
                        }
                    }
                }
                
                self.resultTextView.text = resultMsg
                self.btn.setTitle("复制", for: UIControl.State.normal)
            }
        } else {
            UIPasteboard.general.string = resultTextView.text
            self.view.makeToast("复制成功", duration: 3.0, position: ToastPosition.center)
        }
    }
}
