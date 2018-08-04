//
//  NextViewController.swift
//  CALayerDemo1
//
//  Created by WingChing Yip on 2018/8/4.
//  Copyright © 2018年 WingChing Yip. All rights reserved.
//

import UIKit

// MARK: - 绘制方式二

class NextViewController: UIViewController {

    let drawLayer = ALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建CALayer对象，并添加到view的layer上
        view.layer.addSublayer(drawLayer)
        drawLayer.contentsScale = UIScreen.main.scale
        drawLayer.borderWidth = 5.0
        drawLayer.borderColor = UIColor.red.cgColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let wh = view.frame.width - 40
        drawLayer.frame = CGRect(x: 20, y: 20, width: wh, height: wh)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 3、调用setNeedsDisplay方法
        drawLayer.setNeedsDisplay()
    }
}

// 1、创建一个CALayer的子类
class ALayer: CALayer {
    // 2、子类重写draw方法 进行绘制操作
    override func draw(in ctx: CGContext) {
        // 画笔颜色 （填充）
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.addEllipse(in: CGRect(x: 10, y: 10, width: 50, height: 50))
        // 绘制渲染（填充）
        ctx.fillPath()
    }
}
