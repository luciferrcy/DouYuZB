//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/6.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    // MARK:- 控件属性
    
    @IBOutlet weak var titleLab: UILabel!
        
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    var group : AnchorGroup? {
        didSet {
            titleLab.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}

extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
