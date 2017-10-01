//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/21.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

fileprivate let gameCellID = "gameCellID"
fileprivate let edgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {
    
    // MARK:- 定义数据属性
    var groups : [BaseGameModel]? {
        didSet {
            
            //刷新表格
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随着父控件拉伸而拉伸
        autoresizingMask = []
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: gameCellID)
        
        //给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: edgeInsetMargin, bottom: 0, right: edgeInsetMargin)
        
    }
}

// MARK:- 快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellID, for: indexPath) as! CollectionGameCell
        let group = groups![indexPath.item]
        cell.group = group
        return cell
    }
}
