//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/8/15.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //扩展类方法
    class func createItem(imageName: String, highImage: String, size:CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImage), for: .highlighted)
        btn.frame = CGRect(origin: .zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    /*
     便利构造函数(推荐 不需要写返回值)
     1> convenience 开头
     2> 在构造函数中必须明确调用一个设计的构造函数（self）
     */
    convenience init(imageName: String, highImage: String, size:CGSize?) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImage), for: .highlighted)
        if let s = size {
            btn.frame = CGRect(origin: .zero, size: s)
        }else {
            btn.frame = CGRect(origin: .zero, size: .zero)
        }
        self.init(customView: btn)
    }
}
