//
//  CouponViewController.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-24.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

class CouponViewController: BaseViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var scrollView: UIScrollView! // 顶部tab标签
    @IBOutlet weak var tableView: UITableView!
    
    var coupons:[CouponModel] = []
    var curBtn: UIButton? = nil
    var pageNo: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initViews()
        
        // 添加顶部下拉刷新
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.pageNo = 1
            self.searchCoupons()
            self.tableView.mj_header.endRefreshing()
        })
        // 添加底部上拉加载更多
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.pageNo = self.pageNo + 1
            self.searchCoupons()
            self.tableView.mj_footer.endRefreshing()
        })
        
        searchCoupons()
        
        // 注册couponitemCell
        let couponItemCellNib = UINib(nibName: "CouponItemCell", bundle: nil)
        tableView.register(couponItemCellNib, forCellReuseIdentifier: "couponitemcellid")
        
        tableView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard)))
    }
    
    func initViews() {
        let tabs:[String] = ["淘宝优惠券", "京东优惠券"]
        let width =  (SCREEN_WIDTH / CGFloat(tabs.count)) // 80
        for (index, title) in tabs.enumerated() {
            let button = UIButton.init(frame: CGRect.init(x: CGFloat(index) * width , y: 0, width: width, height: 40))
            button.setTitle(title, for: UIControl.State.normal)
            // 默认第一个按钮选中
            if (index == 0) {
                button.isSelected = true
                curBtn = button
            }
            // 设置按钮选中和未选中标题颜色
            button.setTitleColor(UIColor.blue, for: UIControl.State.selected)
            button.setTitleColor(UIColor.black, for: UIControl.State.normal)
            button.tag = (index + 1)
            button.addTarget(self, action: #selector(tabChanged(btn:)), for: UIControl.Event.touchUpInside)
            scrollView.addSubview(button)
        }
        
        // 滚动区域，当前不需要滚动
//        scrollView.contentSize = CGSize.init(width: CGFloat(tabs.count) * width, height: 40)
    }
    
    // 顶部tab点击
    @objc func tabChanged(btn: UIButton) {
        dismissKeyboard()
        
        if (btn == curBtn) {
            return
        }
        btn.isSelected = true
        curBtn?.isSelected = false
        curBtn = btn
        
        pageNo = 1
        searchCoupons()
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coupons.count
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "couponitemcellid") as! CouponItemCell
        let couponItem = coupons[indexPath.row]
        if (couponItem.imagePath != nil) {
            cell.logoImageView.sd_setImage(with: URL.init(string: couponItem.imagePath!), completed: nil)
        }
        cell.titleLabel.text = couponItem.title
        cell.priceLabel.text = couponItem.price
        cell.infoLabel.text = couponItem.info
        cell.itemUrl = couponItem.itemUrl
        
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
  
    // UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        pageNo = 1
        searchCoupons()
    }

    func searchCoupons() {
        let type = curBtn?.tag
        Api.queryCouponList(type: type!, pageNo: pageNo, keyword: searchBar.text) { (resp, error) in
            let couponList = resp?.value(forKey: "data") as? Array<NSDictionary>
            // 返回优惠券数组不为空
            if (self.pageNo == 1) { // 等于1切换type或关键字搜索，大于1时表示上拉加载更多
                self.coupons.removeAll()
            }
            for couponDic in couponList! {
                self.coupons.append(CouponModel.init(dict: couponDic))
            }
            
            self.tableView.reloadData()
            if (couponList == nil || couponList!.count == 0) { // 没有数据了
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            } else {
                self.tableView.mj_footer.resetNoMoreData()
            }
        }
    }
    
    // 关闭键盘
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}
