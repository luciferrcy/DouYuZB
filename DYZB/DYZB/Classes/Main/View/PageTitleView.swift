//
//  PageTitleView.swift
//  DYZB
//
//  Created by 任楚伊 on 2017/8/16.
//  Copyright © 2017年 任楚伊. All rights reserved.
//

import UIKit

// MARK:- 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index:Int)
}
// MARK:- 定义常量
private let scrollLineH : CGFloat = 2
private let normalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let selectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
// MARK:- 定义PageTitleView类
class PageTitleView: UIView {
    
    var titles : [String]
    var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?

    // MARK:- 添加懒加载属性
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false //不会超过内容范围
        return scrollView
    }()
    
    lazy var titleLabels = [UILabel]()
    
    lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: selectColor.0, g: selectColor.1, b: selectColor.2)
        return scrollLine
    }()

    // MARK:- 自定义构造函数
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置UI界面
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView {
    func setUpUI(){
        //1.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //2.添加title对应的label
        setUpTitleLabels()
        //设置底部的滚动条
        setUpBottomMenuAndScrollLine()
    }
    
    private func setUpTitleLabels(){
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - scrollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            //1.创建UILable
            let label = UILabel()
            
            //2.设置label属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: normalColor.0, g: normalColor.1, b: normalColor.2)
            label.textAlignment = .center
            
            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollview中
            scrollView.addSubview(label)
            
            //5.将label放入数组titleLabels
            titleLabels.append(label)
            
            //6.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setUpBottomMenuAndScrollLine(){
        //1.创建底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1获取第一个label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: selectColor.0, g: selectColor.1, b: selectColor.2)
        //2.2 设置scrollLine的属性
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - scrollLineH, width: firstLabel.frame.width, height: scrollLineH)
        scrollView.addSubview(scrollLine)
    }
}

// MARK:- 监听label的点击
extension PageTitleView {
    @objc func titleLabelClick(tapGes:UITapGestureRecognizer){
        //1 获取当前label
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        //2 获取之前label
        let oldLabel = titleLabels[currentIndex]
        
        //3 切换文字的颜色
        if currentLabel == oldLabel {
            currentLabel.textColor = UIColor(r: selectColor.0, g: selectColor.1, b: selectColor.2)
        }else {
            currentLabel.textColor = UIColor(r: selectColor.0, g: selectColor.1, b: selectColor.2)
            oldLabel.textColor = UIColor(r: normalColor.0, g: normalColor.1, b: normalColor.2)
        }
        
        //4 保存最新label的下标值
        currentIndex = currentLabel.tag
        
        //5 滚动条位置发生改变
        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        
        //6 通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        //1.取出sourceLabel和targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        //2.处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //3.颜色的渐变
        //3.1取出颜色变化范围
        let colorDelta = (selectColor.0 - normalColor.0, selectColor.1 - normalColor.1, selectColor.2 - normalColor.2)
        //3.2变化sourceLabel
        sourceLabel.textColor = UIColor(r: selectColor.0 - colorDelta.0 * progress, g: selectColor.1 - colorDelta.1 * progress, b: selectColor.2 - colorDelta.2 * progress)
        
        //3.3变化targetLabel
        targetLabel.textColor = UIColor(r: normalColor.0 + colorDelta.0 * progress, g: normalColor.1 + colorDelta.1 * progress, b: normalColor.2 + colorDelta.2 * progress)
        
        //4.记录最新的index
        currentIndex = targetIndex
    }
}
