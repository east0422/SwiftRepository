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
    var copyMsg: String? = nil
    var topTitle: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (topTitle != nil) {
            self.title = topTitle
        }
        resultTextView.text = copyMsg     
    }
    
    @IBAction func copyClicked(_ sender: Any) {
        UIPasteboard.general.string = resultTextView.text
        self.view.makeToast("复制成功", duration: 3.0, position: ToastPosition.center)
    }
}
