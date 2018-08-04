//
//  ViewController.swift
//  CALayerDemo1
//
//  Created by WingChing Yip on 2018/8/4.
//  Copyright © 2018年 WingChing Yip. All rights reserved.
//

import UIKit

// MARK: -绘制方式一

class ViewController: UIViewController {
    
    let drawLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // CALayer 就是一个画板，可以在里面画内容
        // 1、创建一个CALayer对象，并添加到view的layer上
        view.layer.addSublayer(drawLayer)
        drawLayer.contentsScale = UIScreen.main.scale // 清晰度, 如果不设置，所画的圆会变模糊
        drawLayer.borderColor = UIColor.cyan.cgColor
        drawLayer.borderWidth = 5.0
        // 2、设置layer的delegate
        drawLayer.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let wh = view.frame.width - 40.0
        drawLayer.frame = CGRect(x: 20, y: 20, width: wh, height: wh)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 2、并调用layer的setNeedsDisplay方法 layer进行绘制
        drawLayer.setNeedsDisplay()
    }
}

extension ViewController: CALayerDelegate {
    // 3、实现代理方法，进行绘制操作
    func draw(_ layer: CALayer, in ctx: CGContext) {
        // 画笔颜色 （线）
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.setLineWidth(2.0)
        ctx.addEllipse(in: CGRect(x: 10, y: 10, width: 50, height: 50))
        // 绘制渲染 （线）
        ctx.strokePath()
    }
}
