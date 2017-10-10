//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/5.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

fileprivate let cycleViewH : CGFloat = screenW * 3 / 8
fileprivate let gameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    // MARK:- 懒加载
    
    lazy var recommendVm : RecommendViewModel = RecommendViewModel()
    
    lazy var cycleView : RecommendCycleView = {
       let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(cycleViewH + gameViewH), width: screenW, height: cycleViewH)
        return cycleView
    }()
    
    lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -gameViewH, width: screenW, height: gameViewH)
        return gameView
    }()

}

// MARK:- 设置UI界面内容
extension RecommendViewController {
    override func setupUI() {
        super.setupUI()
        //2.将cycleView加到collectionView中
        collectionView.addSubview(cycleView)
        //3.将gameView加到collectionView中
        collectionView.addSubview(gameView)
        //4.设置collectionView内边距
        collectionView.contentInset = UIEdgeInsetsMake(cycleViewH + gameViewH, 0, 0, 0)
    }
}

// MARK:- 请求数据
extension RecommendViewController {
    override func loadData(){
        baseVM = recommendVm
        recommendVm.requestData { 
            self.collectionView.reloadData()
            var groups = self.recommendVm.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.gameView.groups = groups
            self.loadDataFinished()
        }
        
        recommendVm.requestCycleData {
            self.cycleView.cycleModels = self.recommendVm.cycleModels
        }
    }
}

// MARK:- 遵守UICollection的数据协议
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: prettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = recommendVm.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        }else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: anchorItemW, height: prettyItemH)
        }else {
            return CGSize(width: anchorItemW, height: normalItemH)
        }
    }
}
