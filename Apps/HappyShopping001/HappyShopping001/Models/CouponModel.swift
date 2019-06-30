//
//  CouponModel.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-28.
//  Copyright © 2019年 east. All rights reserved.
//

import Foundation

class CouponModel {
    var imagePath: String? // 商品图片
    var title: String? // 商品名称
    var price: String? // 商品价格
    var info: String? // 商品简介
    var itemUrl: String? // 商品地址
    

    init(dict: NSDictionary) {
        imagePath = dict.value(forKey: "pict_url") as? String
        title = dict.value(forKey: "title") as? String
        price = dict.value(forKey: "zk_final_price") as? String
        info = dict.value(forKey: "coupon_info") as? String
        itemUrl = dict.value(forKey: "item_url") as? String
    }
}
