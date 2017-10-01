//
//  CycleModel.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/20.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    var title : String = ""
    var pic_url : String = ""
    var room : [String:Any]? {
        didSet{
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    var anchor : AnchorModel?
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
