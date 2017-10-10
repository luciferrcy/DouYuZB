//
//  AmuseMenuView.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/10/2.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

private let menuCellID = "menuCellID"

class AmuseMenuView: UIView {
    
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: menuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
    
}

extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {
            return 0
        }else {
            let pageNum = (groups!.count - 1) / 8 + 1
            pageControl.numberOfPages = pageNum
            return pageNum
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellID, for: indexPath) as! AmuseMenuViewCell
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
    private func setupCellDataWithCell(cell: AmuseMenuViewCell, indexPath: IndexPath) {
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        cell.groups = Array(groups![startIndex...endIndex])
    }
}
