//
//  NetworkTools.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/13.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type : MethodType, URLString : String, parameters : [String : String]? = nil, finishedCallback : @escaping(_ result:Any)->()){
        //1.获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        //2.发送网络请求
        Alamofire.request(URLString, method: method, parameters:parameters).responseJSON { response in
            //3.获取结果
            guard let result = response.value else {
                return
            }
            finishedCallback(result)
        }
    }
}
