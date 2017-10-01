//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/10/2.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

let itemMargin : CGFloat = 10
let anchorItemW : CGFloat = (screenW - 3 * itemMargin) / 2
let normalItemH :CGFloat = anchorItemW * 3 / 4
let prettyItemH :CGFloat = anchorItemW * 4 / 3
let headerViewH : CGFloat = 50

let normalCellID = "normalCellID"
let prettyCellID = "prettyCellID"
let headerViewID = "headerViewID"

class BaseAnchorViewController: UIViewController {
    
    // MARK:- 定义属性
    var baseVM : BaseViewModel!
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: anchorItemW, height: normalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        layout.headerReferenceSize = CGSize(width: screenW, height: headerViewH)
        //2.创建UIcollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: normalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: prettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewID)
        return collectionView
        }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}


// MARK:- 设置UI
extension BaseAnchorViewController {
    func setupUI(){
        view.addSubview(collectionView)
    }
}

// MARK:- 请求数据
extension BaseAnchorViewController {
    func loadData(){
        
    }
}


// MARK:- 遵守UICollectionView的数据源和协议
extension BaseAnchorViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellID, for: indexPath) as! CollectionNormalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}
