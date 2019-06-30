//
//  GuideViewController.swift
//  HappyShopping001
//
//  Created by dfang on 2019-9-16.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit
import WebKit

class GuideViewController: BaseViewController {
    
    @IBOutlet weak var guideWebView: WKWebView!
    var urlStr: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (urlStr == nil) {
            urlStr = "http://localhost/guide?noCache=\(NSDate().timeIntervalSince1970)"
        }
        let url = URL.init(string: urlStr!)
        let urlRequest = URLRequest.init(url: url!)
        guideWebView.load(urlRequest)
    }
}
