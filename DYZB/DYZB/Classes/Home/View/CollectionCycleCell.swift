//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/20.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title ?? ""
            guard let url = URL(string: cycleModel?.pic_url ?? "") else {
                return
            }
            let resource = ImageResource(downloadURL: url)
            iconImageView.kf.setImage(with: resource)
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
}
