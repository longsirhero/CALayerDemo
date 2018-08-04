//
//  ViewController.swift
//  CALayerDemo2
//
//  Created by WingChing Yip on 2018/8/4.
//  Copyright © 2018年 WingChing Yip. All rights reserved.
//

import UIKit


// MARK: -视频教程：https://www.imooc.com/learn/1015 第3章CALayer绘制实战
class ViewController: UIViewController {
    
    let slider = UISlider(frame: CGRect.zero)
    
    let layerOne = ProgressOneLayer()
    let layerTwo = ProgressTwoLayer()
    let layerThree = ProgressThreeLayer()
    let layerFour = ProgressFourLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(slider)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        view.layer.addSublayer(layerOne)
        layerOne.number = 0.0 // 设置默认值
        view.layer.addSublayer(layerTwo)
        layerTwo.number = 0.0
        view.layer.addSublayer(layerThree)
        layerThree.number = 0.0
        view.layer.addSublayer(layerFour)
        layerFour.number = 0.0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        slider.frame = CGRect(x: 50, y: 70, width: view.frame.width - 100.0, height: 30)
        
        let lwh: CGFloat = 100
        let horSpace = (view.frame.width - 2 * lwh) / 3
        
        layerOne.frame = CGRect(x: horSpace, y: 110, width: lwh, height: lwh)
        layerTwo.frame = CGRect(x: horSpace*2+lwh, y: 110, width: lwh, height: lwh)
        layerThree.frame = CGRect(x: horSpace, y: 110+lwh+30, width: lwh, height: lwh)
        layerFour.frame = CGRect(x: horSpace*2+lwh, y: 110+lwh+30, width: lwh, height: lwh)

    }

    @objc private func sliderValueChanged() {
        layerOne.number = Double(slider.value)
        layerTwo.number = Double(slider.value)
        layerThree.number = Double(slider.value)
        layerFour.number = Double(slider.value)
    }
}

// 圆形进度条的父类，用于显示百分比文本
class ProgressLayer: CALayer {
    
    var number: Double = 0.0 {
        didSet {
            tLayer.string = String(format: "%.01f%%", number*100)
            // 开始绘制
            tLayer.setNeedsDisplay()
            self.setNeedsDisplay()
        }
    }
    
    let tLayer: CATextLayer = {
        let l = CATextLayer()
        let font = UIFont.systemFont(ofSize: 12.0)
        l.font = font.fontName as CFTypeRef
        l.fontSize = font.pointSize
        l.alignmentMode = kCAAlignmentCenter
        l.foregroundColor = UIColor.blue.cgColor
        l.string = ""
        l.contentsScale = UIScreen.main.scale
        l.isWrapped = true
        return l
    }()
    
    override init() {
        super.init()
        self.addSublayer(tLayer)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        
        // infinity 无穷大
        // 算出文本的高度
        let th = NSString(string: "100%").boundingRect(with: CGSize(width: CGFloat.infinity, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12.0)], context: nil).height
        
        tLayer.frame = CGRect(x: 0, y: self.frame.height * 0.5 - th*0.5 , width: self.frame.width, height: th)
    }
}

// 第一个圆弧(需要实时算endAngle)
class ProgressOneLayer: ProgressLayer {
    override func draw(in ctx: CGContext) {
        // 半径
        let radiu = self.frame.width * 0.45
        // 中心点
        let center = CGPoint(x: self.frame.width*0.5, y: self.frame.height*0.5)
        
        ctx.setStrokeColor(UIColor.cyan.cgColor)
        ctx.setLineWidth(radiu * 0.08)
        // 设置蹲点的形状
        ctx.setLineCap(CGLineCap.round)
        // 算出终点角度
        let endAngle = CGFloat(self.number) * CGFloat.pi * 2.0 - CGFloat.pi * 0.5
        ctx.addArc(center: center, radius: radiu, startAngle: -0.5*CGFloat.pi, endAngle: endAngle, clockwise: false)
        ctx.strokePath()
    }
}

// 第二个圆弧(需要实时算endAngle)
class ProgressTwoLayer: ProgressLayer {
    override func draw(in ctx: CGContext) {
        // 半径
        let radiu = self.frame.width * 0.45
        // 中心点
        let center = CGPoint(x: self.frame.width*0.5, y: self.frame.height*0.5)
        
        ctx.setFillColor(UIColor.yellow.cgColor)
        ctx.move(to: center)
        ctx.addLine(to: CGPoint(x: center.x, y: self.frame.height*0.05))
        let endAngle = CGFloat(self.number) * CGFloat.pi * 2.0 - CGFloat.pi * 0.5
        ctx.addArc(center: center, radius: radiu, startAngle: -0.5*CGFloat.pi, endAngle: endAngle, clockwise: false)
        
        ctx.closePath()
        ctx.fillPath()
    }
}

// 第三个圆弧(需要实时算startAngle和endAngle)
class ProgressThreeLayer: ProgressLayer {
    override func draw(in ctx: CGContext) {
        // 半径
        let radiu = self.frame.width * 0.45
        // 中心点
        let center = CGPoint(x: self.frame.width*0.5, y: self.frame.height*0.5)
        
        // 画圆
        ctx.setStrokeColor(UIColor.gray.withAlphaComponent(0.3).cgColor)
        ctx.setLineWidth(radiu*0.076) // 线宽
        ctx.addEllipse(in: CGRect(x: self.frame.width*0.05, y: self.frame.height*0.05, width: self.frame.width*0.9, height: self.frame.height*0.9))
        ctx.strokePath()

        ctx.setFillColor(UIColor.orange.cgColor)

        let startAngle = CGFloat.pi * 0.5 - CGFloat(self.number) * CGFloat.pi
        let endAngle = CGFloat.pi * 0.5 + CGFloat(self.number) * CGFloat.pi
        ctx.addArc(center: center, radius: radiu, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        ctx.closePath()
        ctx.fillPath()
    }
}

// 第四个圆弧(需要实时算endAngle)
class ProgressFourLayer: ProgressLayer {
    override func draw(in ctx: CGContext) {
        // 半径
        let radiu = self.frame.width * 0.45
        // 中心点
        let center = CGPoint(x: self.frame.width*0.5, y: self.frame.height*0.5)
        
        // 画圆
        ctx.setStrokeColor(UIColor.gray.withAlphaComponent(0.8).cgColor)
        ctx.setLineWidth(radiu*0.07) // 线宽
        ctx.addEllipse(in: CGRect(x: self.frame.width*0.05, y: self.frame.height*0.05, width: self.frame.width*0.9, height: self.frame.height*0.9))
        ctx.strokePath()
        
        // 画上面拖动的圆弧
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.setLineWidth(radiu * 0.08)
        // 设置蹲点的形状
        ctx.setLineCap(CGLineCap.round)
        // 算出终点角度
        let endAngle = CGFloat(self.number) * CGFloat.pi * 2.0 - CGFloat.pi * 0.5
        ctx.addArc(center: center, radius: radiu, startAngle: -0.5*CGFloat.pi, endAngle: endAngle, clockwise: false)
        ctx.strokePath()
    }
}
