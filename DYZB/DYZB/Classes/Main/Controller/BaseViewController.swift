//
//  BaseViewController.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/10/10.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var contentView : UIView?
    
    lazy var animImageView : UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = 0
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

}

extension BaseViewController {
    func setupUI(){
        //1. 先隐藏内容view
        contentView?.isHidden = true
        //2.添加执行动画的imageView
        view.addSubview(animImageView)
        //3.给animImageView执行动画
        animImageView.startAnimating()
        //4.设置view背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished(){
        animImageView.stopAnimating()
        animImageView.isHidden = true
        contentView?.isHidden = false
    }
}
