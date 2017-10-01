//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/10.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionBaseCell {
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }

}
