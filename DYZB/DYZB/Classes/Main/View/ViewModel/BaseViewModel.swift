//
//  BaseViewModel.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/10/2.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

class BaseViewModel {
    var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroup: Bool ,URLString: String, parameters: [String:String]? = nil, finishedCallBack: @escaping() -> ()) {
        NetworkTools.requestData(type: .GET, URLString: URLString, parameters: parameters) { (result) in
            guard let resultDict = result as? [String : Any] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {
                return
            }
            if isGroup {
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            }else {
                let group = AnchorGroup()
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            finishedCallBack()
        }
    }
}
