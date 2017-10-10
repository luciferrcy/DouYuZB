//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/14.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel {
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData(finishedCallback : @escaping ()->()){
        //0.创建group
        let dispatch_group = DispatchGroup()
        //1.请求第一部分推荐数据
        dispatch_group.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime()]) { (result) in
            //1.将result转成字典
            guard let resultDict = result as? [String : Any] else {
                return
            }
            //2.根据data该key获取数组
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {
                return
            }
            //3.遍历数组,获取字典,并且将字典转成模型对象
            self.bigDataGroup.tag_name = "热点"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray {
                let anchors = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchors)
            }
            dispatch_group.leave()
        }

        //2.请求第二部分颜值数据
        dispatch_group.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]) { (result) in
            //1.将result转成字典
            guard let resultDict = result as? [String : Any] else {
                return
            }
            //2.根据data该key获取数组
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {
                return
            }
            //3.遍历数组,获取字典,并且将字典转成模型对象
            //3.1 设置组属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dispatch_group.leave()
        }
        //3.请求2.12部分游戏数据
        dispatch_group.enter()
        loadAnchorData(isGroup: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]) {
            dispatch_group.leave()
        }
        
        //判断所有的数据都请求到再排序
        dispatch_group.notify(queue: .main) { 
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishedCallback()
        }
        
    }
    
    //请求无限轮播数据
    func requestCycleData(finishedCallback : @escaping() -> ()){
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version":"2.300"]) { (result) in
            guard let resultDict = result as? [String : Any] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {
                return
            }
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finishedCallback()
        }
    }
}
