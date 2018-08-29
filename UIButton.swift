//
//  UIButton.swift
//  BSTrade
//
//  Created by 刘芳友 on 2018/5/8.
//  Copyright © 2018年 Bluestone. All rights reserved.
//

import UIKit

extension UIButton {

    /// 设置Button 渐变背景图
    ///
    /// - Parameters:
    ///   - colors: 渐变颜色
    ///   - percentAges: 颜色分布
    ///   - gradientDirection: 线性渐变方向
    ///   - state: 按钮状态
    func setGradientBackgroundImage(_ colors:[UIColor],normalColor:UIColor? = nil,percentAges:[CGFloat] = [0,1],gradientDirection:GradientDirectionType = .horizontal,state:UIControlState) {
        let image = UIImage.createImageWithSize(self.frame.size, gradientColors: colors.map{$0.cgColor}, percentAge: percentAges, gradientType: gradientDirection)
        if let nColor = normalColor,
            let img = image,
            let normalImg = UIImage.createImageForColorWith(CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: self.frame.size), color: nColor){
            self.dk_setBackgroundImage(DKImagePickerWithSwiftImages(normalImg,img), for: state)
        }else {
            self.setBackgroundImage(image, for: state)
        }
    }
    
    
    /// 设置Button 颜色图片背景
    ///
    /// - Parameters:
    ///   - colors: 颜色分组
    ///   - state: 按钮状态
    func dk_setBackgroundImageWithColor(_ colors:DkColors,state:UIControlState) {
        guard let images = UIImage.createDKImageForDKColorWith(CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: self.frame.size), colors: colors) else { return }
        self.dk_setBackgroundImage(DKImagePickerWithSwiftImages(images.0,images.1), for: state)
    }
    
    /// 设置Button 颜色图片背景
    ///
    /// - Parameters:
    ///   - colors: 颜色分组
    ///   - state: 按钮状态
    func dk_setBackgroundImageWithDKColorPicker(_ colors:DKColorPicker,state:UIControlState) {
        let dColor = colors("DEFAULT")
        let lColor = colors("LIGHT")
        if let d = dColor,let l = lColor {
            self.dk_setBackgroundImageWithColor((d,l), state: state)
        }
        
    }
    
    func setBackgroundImageWithColor(_ color:UIColor,state:UIControlState) {
        let image = UIImage.createImageForColorWith(CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: self.frame.size), color: color)
        self.setBackgroundImage(image, for: state)
    }
    
    
    /// 设置Button圆角 颜色图片背景
    ///
    /// - Parameters:
    ///   - colors: 颜色分组
    ///   - type: 圆角位置
    ///   - state: 按钮状态
    func setBorderBackgroundImageWithColor(_ backgroundColors:DkColors,lineColors:DkColors,state:UIControlState,type:BorderCornerPositionType) {
        guard let images = UIImage.createButtonBorderImage(CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: self.frame.size), backgroundcolors: backgroundColors,lineColors: lineColors, type: type) else { return }
        self.dk_setBackgroundImage(DKImagePickerWithSwiftImages(images.0,images.1), for: state)
    }
}
