//
//  GameViewModel.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/25.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameModel(finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            guard let resultDict = result as? [String:Any] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {
                return
            }
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            finishedCallBack()
        }
    }
}
