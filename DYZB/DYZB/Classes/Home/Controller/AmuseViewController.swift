//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/29.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

fileprivate let menuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -menuViewH, width: screenW, height: menuViewH)
        return menuView
    }()

}

// MARK:- 设置UI
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: menuViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension AmuseViewController {
    override func loadData(){
        baseVM = amuseVM
        
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            var tempGroup = self.amuseVM.anchorGroups
            tempGroup.removeFirst()
            self.menuView.groups = tempGroup
            self.loadDataFinished()
        }
    }
}
