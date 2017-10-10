//
//  FunnyViewModel.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/10/8.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback:@escaping()->()){
        loadAnchorData(isGroup: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : "30", "offset" : "0"], finishedCallBack: finishedCallback)
    }
}
