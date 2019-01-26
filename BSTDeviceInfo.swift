//
//  BSTDeviceInfo.swift
//  BSTrade
//
//  Created by lfy on 2017/10/12.
//  Copyright © 2017年 Bluestone. All rights reserved.
//

import UIKit


class BSTDeviceInfo: NSObject {

    //获取系统版本号
    @objc class func getCurrentSystemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    //获取设备名称
    @objc class func getDeviceName() -> String {
        return UIDevice.current.name
    }
    
    //APP生产版本号
    @objc class func getAppVersion() -> String {
        let info = Bundle.main.infoDictionary
        guard let shortVersionString = info?["CFBundleShortVersionString"] as? String else {
            return "0"
        }
        return shortVersionString
    }
    //获取UUID
    @objc class func getDeviceUUID() -> String {
        guard let uuidStr = UIDevice.current.identifierForVendor?.uuidString else {
            return "uuid=null"
        }
        return uuidStr
    }
    
    //获取APPbuild 版本号
    @objc class func getAppBuildVersion() -> String {
        let info = Bundle.main.infoDictionary
        guard let buildVersionString = info?["CFBundleVersion"] as? String else {
            return "0"
        }
        return buildVersionString
    }
    
    //获取手机的设备类型
    @objc class func getDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
            
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch (5 Gen)"
        case "iPod7,1":   return "iPod Touch 6"
            
        //iPhone系列
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1","iPhone5,2":  return "iPhone 5"
        case "iPhone5,3","iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1","iPhone6,2":  return "iPhone 5s"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1" ,"iPhone9,3":  return "iPhone 7"
        case "iPhone9,2" ,"iPhone9,4":  return "iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
        
        //iPad系列
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":   return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
        case "i386", "x86_64":   return "Simulator"
        default:  return identifier
        }
    }
}

/**
 *  根据屏幕尺寸返回设备系列
 */
struct DeviceSize {
    
    ///iPhone X顶部安全区域高度
    static let iPhoneXTopSafeHeight:CGFloat = currentDeviceSize() == .iPhoneX ? 44 : 20
    
    ///iPhone X底部安全区域高度
    static let iPhoneXBottomSafeHeight:CGFloat = currentDeviceSize() == .iPhoneX ? 34 : 0
    
    enum DeviceType {
        case iPhone4 // 4,4S
        case iPhone5 // 5,5S,5C
        case iPhone6 // 6,6S,7
        case iPhone6P // 6SP,7P
        case iPhoneX   //iPhone X, XS
        case iPhoneXR  // iPhone XR, XS Max
    }
    
    //判断屏幕类型
    static func currentDeviceSize() -> DeviceType {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        switch (screenWidth, screenHeight) {
        case (320, 480),(480, 320):
            return .iPhone4
        case (320, 568),(568, 320):
            return .iPhone5
        case (375, 667),(667, 375):
            return .iPhone6
        case (414, 736),(736, 414):
            return .iPhone6P
        case (375, 812),(812, 375):
            return .iPhoneX
        case (414, 896), (896, 414):
            return .iPhoneXR
        default:
            return .iPhone6P
        }
    }
    
    
    /// 判断iPhone 是否为留海系列
    ///
    /// - Returns: true x系列
    static func isiPhoneXSeries() -> Bool {
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
            return false
        }
        
        if #available(iOS 11.0, *) {
            let mainWindow = UIApplication.shared.delegate?.window
            if  let bottom = mainWindow??.safeAreaInsets.bottom, bottom > 0.0 {
                return true
            }
        }
        return false
    }
}
