//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/29.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

class AmuseViewController: BaseAnchorViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()

}

// MARK:- 请求数据
extension AmuseViewController {
    override func loadData(){
        baseVM = amuseVM
        
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}
