//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/19.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {
    // MARK:- 设置控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet{
            guard let anchor = anchor else {
                return
            }
            var onlineStr = ""
            if anchor.online >= 10000 {
                onlineStr = "\(anchor.online/10000)万在线"
            }else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            nicknameLabel.text = anchor.nickname
            
            guard let url = URL(string: anchor.vertical_src) else {
                return
            }
            
            let resource = ImageResource(downloadURL: url)
            
            iconImageView.kf.setImage(with: resource)
        }
    }
}
