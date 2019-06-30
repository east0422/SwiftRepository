//
//  UserInfoModel.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-28.
//  Copyright © 2019年 east. All rights reserved.
//

import Foundation

class UserInfoModel: NSObject, NSCoding {
    
    static var sharedUser: UserInfoModel?
    
    var exesis: Int // 1,存在; 0,不存在
    var mobile: String // 手机号
    var msg: String // 状态结果
    var sign: Int // 标志
    
    func encode(with coder: NSCoder) {
        coder.encode(exesis, forKey: "exesis")
        coder.encode(mobile, forKey: "mobile")
        coder.encode(msg, forKey: "msg")
        coder.encode(sign, forKey: "sign")
    }
    
    required init?(coder decoder: NSCoder) {
        self.exesis = decoder.decodeInteger(forKey: "exesis")
        self.mobile = decoder.decodeObject(forKey: "mobile") as! String
        self.msg = decoder.decodeObject(forKey: "msg") as! String
        self.sign = decoder.decodeInteger(forKey: "sign")
    }
    
    // 构造方法
    required init(dict: NSDictionary) {
        self.exesis = dict.value(forKey: "exesis") as? Int ?? 0
        self.mobile = dict.value(forKey: "mobile") as? String ?? ""
        self.msg = dict.value(forKey: "msg") as? String ?? ""
        self.sign = dict.value(forKey: "sign") as? Int ?? 0
    }
    
    // 保存对象
    class func saveUserInfo(userInfo: UserInfoModel) {
        let userInfoData = NSKeyedArchiver.archivedData(withRootObject: userInfo)
        UserDefaults.standard.set(userInfoData, forKey: "userInfo")
        sharedUser = userInfo
    }
    
    // 类方法，获取对象
    class func fetchUserInfo() -> UserInfoModel? {
        if (sharedUser == nil) {
            let userInfoData = UserDefaults.standard.data(forKey: "userInfo")
            if (userInfoData != nil) {
                sharedUser = NSKeyedUnarchiver.unarchiveObject(with: userInfoData!) as? UserInfoModel
            }
        }
        
        return sharedUser
    }
    
    // 类方法，删除用户信息
    class func removeUserInfo() {
        UserDefaults.standard.removeObject(forKey: "userInfo")
        sharedUser = nil
    }
}
