//
//  HomePageViewController.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-24.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit
import Toast_Swift

class HomePageViewController: BaseViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTextView.layer.borderColor = UIColor.red.cgColor
        resultTextView.layer.borderWidth = 1.0
        resultTextView.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.text = ""
        // 默认隐藏查询结果视图，显示背景图片，有查询结果再显示结果视图
        resultView.isHidden = true
    }
    
    // UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if (searchBar.text == nil || searchBar.text?.count == 0) {
            return
        }
        Api.queryMsg(msg: searchBar.text!) { (resp, error) in
            var result = "对不起，没有查询结果！"
            if (error != nil) {
                result = error?.localizedDescription ?? "对不起，查询出错！"
            } else {
                let respData = resp?.value(forKey: "data") as? NSDictionary
                if (respData != nil) {
                    result = respData!.value(forKey: "msg") as! String
                }
            }
            
            self.resultTextView.text = result
            // 显示查询结果
            self.resultView.isHidden = false
        }
    }
    
    @IBAction func copyBtnClicked(_ sender: UIButton) {
        UIPasteboard.general.string = resultTextView.text
        self.view.makeToast("复制成功", duration: 3.0, position: ToastPosition.center)
    }
    
    @IBAction func clearBtnClicked(_ sender: UIButton) {
        resultTextView.text = ""
    }
}
