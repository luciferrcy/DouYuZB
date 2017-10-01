//
//  GameViewController.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/25.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

private let edgeMargin : CGFloat = 10
private let itemW : CGFloat = (screenW - 2 * edgeMargin) / 3
private let itemH : CGFloat = itemW * 6 / 5
private let anchorHeaderViewH : CGFloat = 50
private let gameViewH : CGFloat = 90
private let gameCellID = "gameCellID"
private let HeaderViewID = "headerViewID"

class GameViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView:UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: edgeMargin, bottom: 0, right: edgeMargin)
        layout.headerReferenceSize = CGSize(width: screenW, height: anchorHeaderViewH)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: gameCellID)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderViewID)
        return collectionView
    }()
    
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let topHeaderView = CollectionHeaderView.collectionHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -headerViewH - gameViewH, width: screenW, height: headerViewH)
        topHeaderView.titleLab.text = "常用"
        topHeaderView.iconImageView.image = UIImage(named: "img_orange")
        topHeaderView.moreBtn.isHidden = true
        return topHeaderView
    }()
    
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -gameViewH, width: screenW, height: gameViewH)
        return gameView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}

// MARK:- 设置UI
extension GameViewController {
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: headerViewH + gameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension GameViewController {
    fileprivate func loadData(){
        gameVM.loadAllGameModel { 
            self.collectionView.reloadData()
            self.gameView.groups = Array(self.gameVM.games[0..<10])            
        }
    }
}

extension GameViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellID, for: indexPath) as! CollectionGameCell
        cell.group = gameVM.games[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewID, for: indexPath) as! CollectionHeaderView
        //2.设置属性
        headerView.titleLab.text = "全部"
        headerView.iconImageView.image = UIImage(named: "img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}
