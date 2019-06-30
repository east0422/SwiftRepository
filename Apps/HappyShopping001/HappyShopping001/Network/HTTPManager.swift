//
//  HTTPManager.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-25.
//  Copyright © 2019年 east. All rights reserved.
//

import AFNetworking
import SVProgressHUD

// http请求方法
enum RequestMethod {
    case GET
    case POST
}

typealias requestCallack = (_ result: NSDictionary?, _ error: Error?) -> ()

let baseUrl = "http://localhost/index.php"

class HTTPManager: AFHTTPSessionManager {
    // 创建单例
    static let shareInstance:HTTPManager = {
        let manager = HTTPManager()
        
        manager.requestSerializer = AFJSONRequestSerializer()
        // 添加请求头
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        manager.requestSerializer.timeoutInterval = 30.0
        manager.responseSerializer.didChangeValue(forKey: "timeoutInterval")
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        let setArr = NSSet.init(objects: "text/html", "application/json", "text/json")
        // 设置可接收类型
        manager.responseSerializer.acceptableContentTypes = setArr as? Set
        
        //
        return manager
    }()

    // request方法
    func request(method:RequestMethod = RequestMethod.POST, url: String = baseUrl, params: [String: Any]?, callback: @escaping requestCallack)  {
        // 成功回调闭包
        let success = { (task: URLSessionDataTask, respObj: Any?) -> () in
            do {
                SVProgressHUD.dismiss()
                let dict = try JSONSerialization.jsonObject(with: respObj as! Data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                callback(dict, nil)
            } catch {
                print("请求数据出错")
            }
        }
        // 失败回调闭包
        let failure = { (task: URLSessionDataTask?, error: Error?) ->() in
//            print("statusCode\((task?.response as! HTTPURLResponse).statusCode)")
            SVProgressHUD.dismiss()
            callback(nil, error)
        }

        SVProgressHUD.show(withStatus: "努力加载中......")
        if method == RequestMethod.GET {
            get(url, parameters: params, progress: nil, success: success, failure: failure)
        } else {
            post(url, parameters: params, progress: nil, success: success, failure: failure)
        }
    }

}
