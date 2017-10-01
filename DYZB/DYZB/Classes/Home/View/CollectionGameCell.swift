//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/21.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var group : BaseGameModel? {
        didSet {
            guard let group = group else {
                return
            }
            titleLabel.text = group.tag_name
            guard let url = URL(string: group.icon_url) else {
                return
            }
            let resource = ImageResource(downloadURL: url)
            iconImageView.kf.setImage(with: resource)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
