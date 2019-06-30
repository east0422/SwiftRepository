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
    @IBOutlet weak var tableView: UITableView!
    
    var coupons:[CouponModel] = []
    var pageNo: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        Api.queryCouponList(type: 1, pageNo: pageNo, keyword: searchBar.text) { (resp, error) in
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
