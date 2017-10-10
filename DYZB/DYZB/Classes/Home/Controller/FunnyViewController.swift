//
//  FunnyViewController.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/10/2.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

private let topMargin : CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: topMargin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController {
    override func loadData() {
        baseVM = funnyVM
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
}
