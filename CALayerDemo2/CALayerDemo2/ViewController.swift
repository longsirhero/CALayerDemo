//
//  ViewController.swift
//  CALayerDemo2
//
//  Created by WingChing Yip on 2018/8/4.
//  Copyright © 2018年 WingChing Yip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let slider = UISlider(frame: CGRect.zero)
    
    let layerOne = CALayer()
    let layerTwo = CALayer()
    let layerThree = CALayer()
    let layerFour = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(slider)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        view.layer.addSublayer(layerOne)
        view.layer.addSublayer(layerTwo)
        view.layer.addSublayer(layerThree)
        view.layer.addSublayer(layerFour)
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
        
    }
}

