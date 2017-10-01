//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/15.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        return "\(interval)"
    }
}
