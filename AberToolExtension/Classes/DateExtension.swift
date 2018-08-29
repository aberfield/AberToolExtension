//
//  DateExtension.swift
//  BSTrade
//
//  Created by MSY on 2018/1/22.
//  Copyright © 2018年 Bluestone. All rights reserved.
//

import Foundation


/// 时间段
///
/// - day: 白天  8: 00 - 20: 00
/// - night: 晚上  20: 00 - 8: 00
enum TimePhasesType {
    case day
    case night
}

extension Date {

    /// 根据时区获取系统时间
    ///
    /// - Returns: 当前时间
    func getNowDate() -> Date {
        guard let sourceTimeZone = NSTimeZone.init(abbreviation: "UTC") else {return Date()}

        let destinationTimeZone = NSTimeZone.local
        let sourceUTCOffset = sourceTimeZone.secondsFromGMT(for: self)
        let destinationUTCoffset = destinationTimeZone.secondsFromGMT(for: self)
        let interval = TimeInterval(destinationUTCoffset - sourceUTCOffset)
        let destinationDateNow = Date.init(timeInterval: interval, since: self)
        return destinationDateNow
    }

    /// 指定时间返回对应的Date
    ///
    /// - Parameter hour: 指定的时间
    /// - Returns: 对应的Date
    private func getDateWithHour(_ hour: Int) -> Date? {
        let date = Date()
        let currentCalendar = Calendar.init(identifier: .gregorian)
        let currentComps = currentCalendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        var resultComps = DateComponents()
        resultComps.setValue(currentComps.year, for: .year)
        resultComps.setValue(currentComps.month, for: .month)
        resultComps.setValue(currentComps.day, for: .day)
        resultComps.setValue(hour, for: .hour)

        let resultCalendar = Calendar.init(identifier: .gregorian)
        return resultCalendar.date(from: resultComps)
    }

    /// 判断当前时间在哪个时间段
    ///
    /// - Returns: 时间段
    static func getTimePhases() -> TimePhasesType {
        let date = Date()
//        date.getNowDate()
        guard let dayDate = date.getDateWithHour(8),
            let nightDate = date.getDateWithHour(20) else {
            return .day
        }
        if date.compare(dayDate) == .orderedDescending && date.compare(nightDate) == .orderedAscending {
            return .day
        } else {
            return .night
        }
    }
}
