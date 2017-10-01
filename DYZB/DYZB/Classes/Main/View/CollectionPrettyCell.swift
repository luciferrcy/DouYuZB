//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/9/11.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {
    
    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

}
