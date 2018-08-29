//
//  UIImage.swift
//  BSTrade
//
//  Created by 刘芳友 on 2018/5/8.
//  Copyright © 2018年 Bluestone. All rights reserved.
//  UIImage扩展方法

import UIKit

/// 渐变图层方向 水平&垂直
enum GradientDirectionType:Int {
    case horizontal = 0
    case vertical
}

/// 圆角生成位置
enum BorderCornerPositionType {
    case left
    case right
}

typealias DkColors = (dColor:UIColor,lColor:UIColor)

extension UIImage {
    
    /// 根据颜色创建
    ///
    /// - Parameters:
    ///   - imageSize: 图片宽高
    ///   - gradientColors: 渐变颜色
    ///   - percentAge: 颜色分布
    ///   - gradientType: 线性渐变方向
    /// - Returns: 返回根据颜色生成的渐变Image
    static func createImageWithSize(_ imageSize:CGSize,gradientColors:[CGColor],percentAge:[CGFloat],gradientType:(GradientDirectionType)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 1)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let content = UIGraphicsGetCurrentContext() else {return nil}
        content.saveGState()

        let colorSpace =  CGColorSpaceCreateDeviceRGB()
        guard let gradient = CGGradient.init(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations: percentAge) else { return nil }
        
        var start:CGPoint = CGPoint.init(x: imageSize.width, y: imageSize.height)
        var end: CGPoint = CGPoint.init(x: imageSize.width, y: imageSize.height)
        switch gradientType {
        case .horizontal:
            start = CGPoint.init(x: 0, y: imageSize.height/2)
            end =  CGPoint.init(x: imageSize.width,y:imageSize.height/2)
        case .vertical:
            start = CGPoint.init(x: imageSize.width/2, y: 0.0)
            end =  CGPoint.init(x:imageSize.width/2,y:imageSize.height)
        }
        
        content.drawLinearGradient(gradient, start: start, end: end, options: .drawsBeforeStartLocation)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    
    /// 根据两种不同颜色生成对应的两张图片
    ///
    /// - Parameters:
    ///   - imageRect: 生成图片大小
    ///   - colors: 需要生成的颜色
    /// - Returns: 两张图片
    static func createDKImageForDKColorWith(_ imageRect:CGRect,colors:DkColors) -> (UIImage,UIImage)? {
        UIGraphicsBeginImageContext(imageRect.size)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let content = UIGraphicsGetCurrentContext() else {return nil}
        content.saveGState()
        content.setFillColor(colors.dColor.cgColor)
        content.fill(imageRect)
        guard let dImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }

        content.setFillColor(colors.lColor.cgColor)
        content.fill(imageRect)
        guard let lImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        return (dImage,lImage)
    }
    
    /// 根据颜色生成对应的图片
    ///
    /// - Parameters:
    ///   - imageRect: 生成图片大小
    ///   - colors: 需要生成的颜色
    /// - Returns: 图片
    static func createImageForColorWith(_ imageRect:CGRect,color:UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(imageRect.size)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let content = UIGraphicsGetCurrentContext() else {return nil}
        content.saveGState()
        content.setFillColor(color.cgColor)
        content.fill(imageRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    /// 根据颜色生成圆角图片
    ///
    /// - Parameters:
    ///   - imageRect: 生成图片大小
    ///   - backgroundcolors: 生成图片的颜色
    ///   - lineColors: 生成图片的颜色
    ///   - type: 左边圆角还是右边圆角
    /// - Returns: 生成的圆角图片
    static func createButtonBorderImage(_ imageRect:CGRect,backgroundcolors:DkColors,lineColors:DkColors,type:BorderCornerPositionType) -> (UIImage,UIImage)? {
        UIGraphicsBeginImageContext(imageRect.size)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let content = UIGraphicsGetCurrentContext() else {return nil}
        content.saveGState()
        
        var corner = UIRectCorner.topLeft
        switch type {
        case .left:
            corner = [UIRectCorner.topLeft, UIRectCorner.bottomLeft]
        case .right:
            corner = [UIRectCorner.topRight, UIRectCorner.bottomRight]
        }
        let maskPath = UIBezierPath.init(roundedRect: imageRect, byRoundingCorners: corner, cornerRadii: CGSize.init(width: 4, height: 4))
        maskPath.lineWidth = 0.5
        maskPath.addClip()
        lineColors.dColor.setStroke()
        maskPath.stroke()
        content.addPath(maskPath.cgPath)
        
        content.setFillColor(backgroundcolors.dColor.cgColor)
        content.fill(imageRect)
        content.setStrokeColor(lineColors.dColor.cgColor)
        content.stroke(imageRect)

        guard let dImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }

        lineColors.lColor.setStroke()
        maskPath.stroke()
        content.setFillColor(backgroundcolors.lColor.cgColor)
        content.setStrokeColor(lineColors.lColor.cgColor)
        content.fill(imageRect)
        content.stroke(imageRect)
        
        guard let lImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        return (dImage,lImage)
    }
    
    //绘制二维码图片
    static func drawQRImage(size imageSize:CGSize) {
        let qrcodeImage = UIImage(named: "qrcodeImg")
        guard let _qrImage = qrcodeImage else {
            return
        }
        
        let imageScale = _qrImage.size.width / _qrImage.size.height
        let qrW = imageSize.width
        let qrH = qrW / imageScale
        let qrY : CGFloat = imageSize.height - qrH
        _qrImage.draw(in: CGRect(x: 0, y: qrY, width: qrW, height: qrH))
    }

}
