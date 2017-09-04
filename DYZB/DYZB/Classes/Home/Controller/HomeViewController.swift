//
//  HomeViewController.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/8/15.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

private let titleViewH:CGFloat = 40

class HomeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    lazy var pageTitleView:PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: statusBarH + navigationBarH, width: screenW, height: titleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    lazy var pageContentView: PageContentView = {[weak self] in
        //确定内容frame
        let contentH = screenH - (statusBarH + navigationBarH + titleViewH)
        let contentFrame = CGRect(x: 0, y: statusBarH + navigationBarH + titleViewH, width: screenW, height: contentH)
        //确定所有子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()

    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK:- 设置UI界面

extension HomeViewController {
    func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏
        setupNavigationBar()
        //添加titleView
        view.addSubview(pageTitleView)
        //添加contentView
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar(){
        let btn = UIButton()
        btn.setImage(UIImage(named:"homeLogoIcon"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        let historyItem = UIBarButtonItem(image: #imageLiteral(resourceName: "viewHistoryIcon"), style: .plain, target: self, action: #selector(HomeViewController.toHistory))
        let searchItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchBtnIcon"), style: .plain, target: self, action: #selector(HomeViewController.toSearch))
        let qrcodeItem = UIBarButtonItem(image: #imageLiteral(resourceName: "scanIcon"), style: .plain, target: self, action: #selector(HomeViewController.toScan))
        navigationItem.rightBarButtonItems = [searchItem,qrcodeItem,historyItem]
        navigationController?.navigationBar.barTintColor = UIColor.orange
    }

}

// MARK:- 遵守协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- 导航按钮跳转
extension HomeViewController {
    //历史
    func toHistory(){
        
    }
    
    //搜索
    func toSearch(){
        
    }
    
    //扫码
    func toScan(){
        
    }
}
