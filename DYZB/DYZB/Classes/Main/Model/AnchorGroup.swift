//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/15.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    //该组对应的房间信息
    var room_list : [[String : Any]]? {
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //组显示的图标
    var icon_name : String?
    //定义主播模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
}
