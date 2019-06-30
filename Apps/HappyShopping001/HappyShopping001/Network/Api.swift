//
//  Api.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-25.
//  Copyright © 2019年 east. All rights reserved.
//
import Foundation

class Api {
    
    // 登录
    static func login(account: String, callback:@escaping requestCallack) {
        let params = ["type": "login",
                      "user": account
                    ]
        HTTPManager.shareInstance.request(params: params) { (resp, error) in
            callback(resp, error)
        }
    }
    
    // 注册
    static func register(regaccount: String, inviteaccount: String?, callback:@escaping requestCallack) {
        let params = ["type": "reg",
                      "user": regaccount,
                      "inviter": inviteaccount
                    ]
        HTTPManager.shareInstance.request(params: params as [String : Any]) { (resp, error) in
            callback(resp, error)
        }
    }

    // 查询msg
    static func queryMsg(msg: String, callback:@escaping requestCallack) {
        let params = ["type": "query",
                      "msg": msg.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "",
                      "user": UserInfoModel.fetchUserInfo()?.mobile ?? "",
                      "sign": UserInfoModel.fetchUserInfo()?.sign ?? 0
            ] as [String : Any]
        HTTPManager.shareInstance.request(params: params as [String : Any]) { (resp, error) in
            callback(resp, error)
        }
    }
}
