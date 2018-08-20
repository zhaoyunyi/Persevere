//
//  FoundationExtension.swift
//  XiaoFeiXia
//
//  Created by Jason.Chengzi on 15/12/24.
//  Copyright © 2015年 HVIT. All rights reserved.
//

import Foundation


//MARK: - Properties
//MARK: NSString
extension NSString {
    //判断字符串是否为空内容
    func isEmpty() -> Bool {
        if self.length < 1 {
            return true
        } else {
            return false
        }
    }
    //对字符串进行md5加密
    func md5() -> NSString {
        return NSString(string: String(self).md5())
    }
    
//    func urlencode() -> NSString {
//        let source = un
//    }

}
//MARK: NSDate
public extension Date {
    //获取当前时间的时间戳
    public var currentTimeStamp: Double {
        get {
            return Double(NSDate().timeIntervalSince1970)
        }
    }
    
    //将NSDate格式的日期转换为时间戳
    public static func convertDateToTimeStamp(date: Date) -> Double {
        return Double(date.timeIntervalSince1970)
    }
    //将时间戳转换为NSDate
    public static func convertTimeStampToDate(timeStamp: Double) -> Date {
        return Date(timeIntervalSince1970: timeStamp)
    }
    
    //将时间戳转换为NSDate
    public static func currentTimeDate() -> Date {
        return Date(timeIntervalSince1970: Date().currentTimeStamp)
    }
    
    //将字符串转换为Double
    public static func convertTimeStrStamp(dateString: String, format: String) -> Double {
        if let date = self.convertStringToDate(dateString: dateString, format: format) {
            return convertDateToTimeStamp(date: date)
        }
        return 0
    }
    
    //将字符串转换为NSDate
    public static func convertStringToDate(dateString: String, format: String) -> Date? {
        if let date = DateFormatter.getCustomedDateFormatterWithFormat(format: format).date(from: dateString) {
            return date
        } else {
            return nil
        }
    }
    //获取时间戳对应的日期字符串
    public func toStringWithTimeStamp(timeStamp: Double) -> String {
        return DateFormatter.getCommonDateFormatter().string(from: Date.convertTimeStampToDate(timeStamp: timeStamp) as Date)
    }
    
    //获取时间戳对应的年份字符串
    public func toIntWithTimeYear(timeStamp: Double) -> Int {
        let date = DateFormatter.getCommonDateYead().string(from: Date.convertTimeStampToDate(timeStamp: timeStamp) as Date)
        var num = 0
        if let date = Int(date) {
            num = date
        }
        return num
    }
    
    //获取时间戳对应的月份字符串
    public func toIntWithTimeMonth(timeStamp: Double) -> Int {
        let date = DateFormatter.getCommonDateMonth().string(from: Date.convertTimeStampToDate(timeStamp: timeStamp) as Date)
        var num = 0
        if let date = Int(date) {
            num = date
        }
        return num
    }
    
    //获取时间戳对应的小时分钟字符串
    public func toStringWithTimeHourMintunte(timeStamp: Double) -> String {
        return DateFormatter.getCommonDateMonthDay().string(from: Date.convertTimeStampToDate(timeStamp: timeStamp) as Date)
    }
    
    //获取时间戳对应的日期字符串
    public func toStringWithTimeStampForSecond(timeStamp: Double) -> String {
        return DateFormatter.getCommonDateFormatterSecond().string(from: Date.convertTimeStampToDate(timeStamp: timeStamp))
    }
    
    //获取日期对应的日期字符串
    public func toStringWithDate(date: Date) -> String {
        return DateFormatter.getCommonDateFormatter().string(from: date)
    }
    public func toString() -> String {
        return DateFormatter.getCommonDateFormatter().string(from: self)
    }
    //获取日期间隔字符串
    public var intervalStringFromNow: String {
        get {
            if self.timeIntervalSince(Date()) > 0 {
                return "刚刚"
            } else {
                let timeInterval: Int = Int(abs(self.timeIntervalSince(Date())))
                if timeInterval < 60 {
                    return "\(Int(timeInterval % 60))秒前"
                } else if timeInterval < 3600 {
                    return "\(Int((timeInterval / 60) % 60))分钟前"
                } else if timeInterval < 86400 {
                    return "\(Int((timeInterval / 3600) % 24))小时前"
                } else if timeInterval < 604800 {
                    return "\(Int(timeInterval / 86400) % 7)天前"
                } else {
                    return self.toString()
                }
            }
        }
    }
    
    public func isToday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        
        var dCmps: DateComponents = DateComponents()
        dCmps = calendar.dateComponents([.year, .month, .day], from: self)
        
        let now = Date(timeIntervalSince1970: Date().currentTimeStamp)
        var nowCmps: DateComponents = DateComponents()
        nowCmps = calendar.dateComponents([.year, .month, .day], from: now)
        
        return nowCmps.day == dCmps.day && nowCmps.month == dCmps.month && nowCmps.year == dCmps.year
    }
    
    public func intervalTimeTodayOther(time: Int64) -> String {
    
        let timeIntervalDouble: Double =  Double(time.interval())
        
        let timeIntervalDate = Date.convertTimeStampToDate(timeStamp: timeIntervalDouble)
        
        if timeIntervalDate.isToday() {
            return "今天 " + DateFormatter.getCustomedDateFormatterWithFormat(format: "HH:mm")
                .string(from: Date.convertTimeStampToDate(timeStamp: timeIntervalDouble))
        } else {
            return
                DateFormatter.getCustomedDateFormatterWithFormat(format: "MM月dd日 HH:mm")
                .string(from: Date.convertTimeStampToDate(timeStamp: timeIntervalDouble))
        }
    }

    public var intervalDayTimeFromNow: (isEffective: Bool, str: String) {
        get {
            
            if self.timeIntervalSince(Date()) > 0 {
                return (false, "")
            } else {
                let timeInterval = abs(self.timeIntervalSince(Date()))
                let day = 7
                
                if timeInterval < 604800 {
                    return (true, "\(Int(timeInterval / 86400) % day)")
                }
                return (false, "")
            }
        }
    }
    /**
     比较年月
     先比年，年一样，比月份
     前面的比前面的大返回true
     */
    public func compareYearMonth(timeOne: Double, timeTwo: Double) -> Bool {
        let oneYear = self.toIntWithTimeYear(timeStamp: timeOne)
        let oneMonth = self.toIntWithTimeMonth(timeStamp: timeOne)
        
        let twoYear = self.toIntWithTimeYear(timeStamp: timeTwo)
        let twoMonth = self.toIntWithTimeMonth(timeStamp: timeTwo)
        
        /// 返回结果
        var flag = false
        if oneYear > twoYear { //第二个年份比第一个大
            flag = true
        } else if twoYear == oneYear { // 相同年份
            if oneMonth > twoMonth { // 第二个月份
                flag = true
            } else {
                flag = false
            }
        } else {
            flag = false
        }
        return flag
    }
}
//MARK: NSDateFormatter
public extension DateFormatter {
    //获取默认的日期格式
    public class func getCommonDateFormatter() -> DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    public class func getCommonDateFormatterSecond() -> DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateFormat = "yyyy.MM.dd-HH:mm"
        return formatter
    }
    
    public class func getCommonDateYead() -> DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    public class func getCommonDateMonth() -> DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateFormat = "MM"
        return formatter
    }
    
    public class func getCommonDateMonthDay() -> DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateFormat = "MM.dd"
        return formatter
    }
    
    //获取自定义的日期格式
    public class func getCustomedDateFormatterWithFormat(format: String) -> DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateFormat = format
        return formatter
    }
}
//MARK: NSLog
