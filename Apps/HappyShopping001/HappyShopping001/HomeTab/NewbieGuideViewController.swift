//
//  NewbieGuideViewController.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-30.
//  Copyright © 2019年 east. All rights reserved.
//

import WebKit

class NewbieGuideViewController: BaseViewController {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var newbieGuideWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "新人引导"
        self.view.backgroundColor = UIColor.white
        
        let myURL = URL(string: "http://localhost/guide")
        let myRequest = URLRequest(url: myURL!)
        newbieGuideWebView.load(myRequest)
        newbieGuideWebView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //  加载进度条
        if (keyPath == "estimatedProgress") {
//            self.progressView.alpha = 1.0
            progressView.setProgress(Float(newbieGuideWebView.estimatedProgress), animated: true)
            if (newbieGuideWebView.estimatedProgress >= 1.0) {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
//                    self.progressView.alpha = 0.0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
}
