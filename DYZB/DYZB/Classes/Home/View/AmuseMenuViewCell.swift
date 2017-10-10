//
//  AmuseMenuViewCell.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/10/2.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

private let gameCellID = "gameCellID"

class AmuseMenuViewCell: UICollectionViewCell {
    
    var groups : [AnchorGroup]?{
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: gameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }

}

extension AmuseMenuViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellID, for: indexPath) as! CollectionGameCell
        cell.group = groups![indexPath.item]
        cell.clipsToBounds = true
        return cell
    }
}
