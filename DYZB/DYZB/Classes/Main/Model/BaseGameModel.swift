//
//  BaseGameModel.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/25.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    var tag_name : String = ""
    var icon_url : String = ""
    
    override init() {
        
    }
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
