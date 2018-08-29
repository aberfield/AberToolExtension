//
//  FontExtension.swift
//  BSTrade
//
//  Created by MSY on 2017/8/4.
//  Copyright © 2017年 Bluestone. All rights reserved.
//

import Foundation

@objc
extension UIFont {
    class func pfFontSize(_ size: CGFloat) -> UIFont {
        return  UIFont.systemFont(ofSize: size)
    }

    /// 3.5.0 新版字体
    ///
    /// - Parameter size: 字体大小
    /// - Returns: 字体
    class func DinProFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "DINPro", size: size) ?? UIFont.pfFontSize(size)
    }
    
    @nonobjc
    static func font(_ fontType: BSTFontType, isBold: Bool = false) -> UIFont {
        if isBold {
            return UIFont.boldSystemFont(ofSize: fontType.rawValue)
        }
        return UIFont.systemFont(ofSize: fontType.rawValue)
    }

}

enum BSTFontType : CGFloat {
    case major_property = 22.0 //如：净资产数据
    case major_tradePrice = 20.0 //如：交易挂单页数量/价格
    case major_headline = 18.0 //如：标题栏文本

    case common_globalNotice = 16.0 //如：全局提示字体
    case common_stockName = 15.0 //如：行情股票名称、数据
    case common_sysMsgMinorHead = 14.0 //如：系统消息文本、二三级标题

    case minor_iconText = 12.0 //如：图标标题、备注文字
    case minor_stockRemark = 11.0 //如：行情备注数据、股票代码
    case minor_menuText = 10.0 //如：菜单栏文本
}
