//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/10/1.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
    
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallBack: @escaping()->()){
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallBack: finishedCallBack)
    }
}

