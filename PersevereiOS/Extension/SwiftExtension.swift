//
//  SwiftExtension.swift
//  XiaoFeiXia
//
//  Created by Jason.Chengzi on 15/12/24.
//  Copyright © 2015年 HVIT. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate

public struct DeviceSzie {
    
    public enum DeviceType {
        case iphone4
        case iphone5
        case iphone6
        case iphone6p
        case iphone8x
    }
    
    //判断屏幕类型
    public static func currentSize() -> DeviceType {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        switch (screenWidth, screenHeight) {
        case (320, 480),(480, 320):
            return .iphone4
        case (320, 568),(568, 320):
            return .iphone5
        case (375, 667),(667, 375):
            return .iphone6
        case (414, 736),(736, 414):
            return .iphone6p
        default:
            return .iphone8x
        }
    }
}

//MARK: String
public extension String {
    func toBytes() -> [UInt8] {
        var bytes = [UInt8]()
        for char in self.utf8{
            bytes += [char]
        }
        return bytes
    }
    
    func length() -> Int {
        return self.count
    }
    
    static func stringWithUUID() -> String {
        
        let uuidRef = CFUUIDCreate(kCFAllocatorDefault)
        let strRef = CFUUIDCreateString(kCFAllocatorDefault, uuidRef)
        let uuidString = (strRef! as String).replacingOccurrences(of: "-", with: "")
        return uuidString
    }
    
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        return String(format: hash as String)
    }

    func intValue() -> Int? {
        return Int(self)
    }
    func floatValue() -> Float? {
        return Float(self)
    }
    func doubleValue() -> Double? {
        return Double(self)
    }
    func userDirectory() -> String {
        return NSHomeDirectory() + "/Documents/\(self)/"
    }
    func hideTextCenterString(leftNumber: Int, rightNumber: Int) -> String {
        let starCount = self.length() - leftNumber - rightNumber
        let replanceStar = NSMutableString()
        for _ in 0 ..< starCount {
            replanceStar.append("*")
        }
        let tempString = NSMutableString(string: self)
        tempString.replaceCharacters(in: NSMakeRange(leftNumber, starCount), with: replanceStar as String)
        return tempString as String
    }
    func replanceDotFor() -> String {
        
        return self.replacingOccurrences(of: "-", with: ".")
    }
    func replanceDot(str: String) -> String {
        return self.replacingOccurrences(of: str, with: ".")
    }
    
//    func rangeStringLast(rangeStr: String) -> String {
//
//        let str: Range = self.range(of: rangeStr)!
//
////        self.substring(from: str.upperBound)
//        self.substring(from: <#T##Int#>)
//        return self.substring(from: str.upperBound)
//    }
    
}

public extension String {
//    func index(from: Int) -> Index {
//        return self.index(startIndex, offsetBy: from)
//    }
//
//    func substring(from: Int) -> String {
//        let fromIndex = index(from: from)
//        return substring(from: fromIndex)
//    }
//
//    func substring(to: Int) -> String {
//        let toIndex = index(from: to)
//        return substring(to: toIndex)
//    }
//
//    func substring(with r: Range<Int>) -> String {
//        let startIndex = index(from: r.lowerBound)
//        let endIndex = index(from: r.upperBound)
//        return substring(with: startIndex..<endIndex)
//    }
    // 取出字符中所有数字
    public func substringForInt() -> Int? {
        
        var chars = ""
        for char in self {
            if Int(char.description) != nil {
                chars.append(char)
            }
        }
        
        return Int(chars)
    }
    
    public var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F:   // Variation Selectors
                return true
            default:
                continue
            }
        }
        return false
    }
}

extension NSString {
//    func rangeStringLast(rangeStr: String) -> String {
//        
//        let str = NSString.rang
//        return str
//    }
    
    func StringWidthBySize(size: CGSize, font: UIFont) -> CGFloat {
        
        let attribute = NSDictionary(dictionary: [NSAttributedStringKey.font: font])
        let retSize: CGSize = self.boundingRect(with: size, options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], attributes: attribute as? [NSAttributedStringKey : Any], context: nil).size
        
        return retSize.height
    }
}

extension Float {
    func pointTwo(numOne: Int, numTwo: Int) -> Float {
        
        if numOne < 0 || numTwo < 0 {
            return 0.0000
        }
        
        if numOne == 0 {
            return 0.0000
        }
        var result = Float(numOne / numTwo)
        if result < 0.0001 {
            result = 0.0001
        }
        if result > 1.0000 {
            result = 1.0000
        }
        return result
    }
}

public extension Int {
//    /**
//     转换万位
//     
//     - returns: 返回字符串
//     */
//    func tenThousand() -> String {
//        let num = Double(self) / Double(1000000)
//        let numRemin = Double(self) % Double(1000000)
//        if numRemin == 0 { // 万位整数
//            return String(num) + "万"
//        }
//        if num < 1 {
//            return String(format: "%.1f万", num)
//        }
//        
//        return String(format: "%.2f万", Double(Double(Int(num * 100.00)) / Double(100)))
//    }
//    
//    func thousand() -> String {
//        let num = Double(self) / Double(1000000)
//        
//        let numRemin = Double(self) % Double(1000000)
//        if numRemin == 0 { // 万位整数
//            return String(num) + "万"
//        }
//        
//        if self < 1000000 {
//            return self.decimaTwo()
//        }
//        
//        return String(format: "%.2f万", Double(Double(Int(num * 100.00)) / Double(100)))
//    }
    
    func likeCount() -> String {
        if self > 999 {
            return "999+"
        } else {
            return "\(self)"
        }
    }
    
    func judgeNumber(money: Int) -> String {
        var number = ""
        if money < 1000 {
            number = money.decimaTwo()
        } else if money < 10000 {
            number = money.decimaOne()
        } else {
            number = money.decimaNone()
        }
        return number
    }
    
    func decimaTwo() -> String {
        let num = Double(self) / Double(100)
        return String(format: "%.2f", num)
    }
    
    func decimaOne() -> String {
        let num = Double(self) / Double(100)
        return String(format: "%.1f", num)
    }
    
    func decimaNone() -> String {
        let num = Double(self) / Double(100)
        return String(format: "%.0f", num)
    }
    
//    func isTransformStr() -> String {
//        if self < 1000000 {
//            return self.decimaNone()
//        } else {
//            return self.tenThousand()
//        }
//    }
    
    public func dayNumber() -> String {
        var day = ""
        if self < 0 {
            day = "0"
        } else if self < 365  {
            day = String(format: "%d", self / 1)
        } else {
            day = String(format: "%d", self / 12)
        }
        return day
    }
    
    public func dayMonth() -> String {
        var day = ""
        if self < 28 {
            day = "0"
        } else {
            day = String(format: "%d", self / 30)
        }
        return day
    }
    
    public func interval() -> Int {
        return self / 1000
    }
}


public extension Int64 {
    public func interval() -> Int {
        return Int(self / Int64(1000))
    }
    
    func chatTimeString() -> String? {
        
        let time = TimeInterval(Double(self))
        // 消息时间
        let date = Date(timeIntervalSince1970: time)
        let dateInRome = DateInRegion(absoluteDate: date)
        // 当前时间
        let now = DateInRegion()
        
        // 相差年份
        let year = now.year - dateInRome.year
        // 相差月数
        let month = now.month - dateInRome.month
        // 相差天数
        let day = now.day - dateInRome.day
        // 相差小时
        let hour = now.hour - dateInRome.hour
        // 相差分钟
        let minute = now.minute - dateInRome.minute
        // 相差秒数
        let second = now.second - dateInRome.second
        
        if year != 0 {
            return String(format: "%d年%d月%d日 %d:%02d", dateInRome.year, dateInRome.month, dateInRome.day, dateInRome.hour, dateInRome.minute)
        } else if year == 0 {
            if month > 0 || day > 7 {
                return String(format: "%d月%d日 %d:%02d", dateInRome.month, dateInRome.day, dateInRome.hour, dateInRome.minute)
            } else if day > 2 {
                return String(format: "%@ %d:%02d", dateInRome.weekdayName, dateInRome.hour, dateInRome.minute)
            } else if day == 2 {
                return String(format: "前天 %d:%d", dateInRome.hour, dateInRome.minute)
            } else if dateInRome.isYesterday {
                return String(format: "昨天 %d:%d", dateInRome.hour, dateInRome.minute)
            } else if hour > 0 {
                return String(format: "%d:%02d",dateInRome.hour, dateInRome.minute)
            } else if minute > 0 {
                return String(format: "%02d分钟前",minute)
            } else if second > 3 {
                return String(format: "%d秒前",second)
            } else  {
                return String(format: "刚刚")
            }
        }
        return ""
    }
    
    func timeStringStyle() -> String? {
        
        let time = TimeInterval(Double(self))
        // 消息时间
        let date = Date(timeIntervalSince1970: time)
        let dateInRome = DateInRegion(absoluteDate: date)
        // 当前时间
        let now = DateInRegion()
        
        // 相差年份
        let year = now.year - dateInRome.year
        // 相差月数
        let month = now.month - dateInRome.month
        // 相差天数
        let day = now.day - dateInRome.day
        // 相差小时
        let hour = now.hour - dateInRome.hour
        // 相差分钟
        let minute = now.minute - dateInRome.minute
        // 相差秒数
        let second = now.second - dateInRome.second
        
        if year != 0 {
            return String(format: "%%d-%d", dateInRome.year, dateInRome.month, dateInRome.day, dateInRome.hour, dateInRome.minute)
        } else if year == 0 {
            if month > 0 || day > 7 {
                return String(format: "%d-%d", dateInRome.month, dateInRome.day, dateInRome.hour, dateInRome.minute)
            } else if day > 2 {
                return String(format: "%@%d:%d", dateInRome.weekdayName, dateInRome.hour, dateInRome.minute)
            } else if day == 2 {
                return String(format: "前天%d:%d", dateInRome.hour, dateInRome.minute)
            } else if dateInRome.isYesterday {
                return String(format: "昨天%d:%d", dateInRome.hour, dateInRome.minute)
            } else if hour > 0 {
                return String(format: "%d:%d",dateInRome.hour, dateInRome.minute)
            } else if minute > 0 {
                return String(format: "%d分钟前",minute)
            } else if second > 3 {
                return String(format: "%d秒前",second)
            } else  {
                return String(format: "刚刚")
            }
        }
        return ""
    }
}

extension Double {
    func rateOneString() -> String {
        return String(format:"%.1f", self * 100)
    }
    
    func rateString() -> String {
        return String(format:"%.2f", self * 100)
    }
    
    func buyValueInt() -> Int {
        return Int(self * 100)
    }
    
    // 嘚嘚指数
    func dedeNumber() -> String {
        if self >= 0 {
            return String(format:"%.0f", self * 100)
        }
        return String(0)
    }
    
    func judgeRate(rate: Double) -> String {
        var value = ""
        if rate > 0.1 {
            value = rate.rateOneString()
        } else {
            value = rate.rateString()
        }
        return value
    }
    
    func scopeDistance() -> String {
        var str = ""
        if self < 100 {
            str = "100米 以内"
        } else if self < 500 {
            str = "500米 以内"
        } else if self < 1000 {
            str = "1km 以内"
        } else {
            str = String(format: "%.3f km", self / 1000)
        }
        
        return str
    }
}
//MARK: Character
extension Character {
    func toInt() -> Int {
        var intFromCharacter:Int = -100
        for i in String(self).utf8
        {
            intFromCharacter = Int(i)
        }
        return intFromCharacter
    }
}
//MARK: Dictionary
extension Dictionary {
    func toString() -> String {
        var stringToReturn = ""
        for key in self.keys {
            stringToReturn += "[\(key): \(String(describing: self[key]))]\n"
        }
        return stringToReturn
    }
}
//MARK: Array
extension Array {
    func toString() -> String {
        var stringToReturn = ""
        for (index, object) in self.enumerated() {
            stringToReturn += "\(index): \(object)"
        }
        return stringToReturn
    }
    
    //获取正确的删除索引
    func getRemoveIndex<T: Equatable>(value: T) -> [Int]{
        
        var indexArray = [Int]()
        
        var correctArray = [Int]()
        
        //获取指定值在数组中的索引
        for (index,_) in self.enumerated() {
            
            if (self[index] as? T) == value {
                
                indexArray.append(index)
            }
        }
        
        //计算正确的删除索引
        for (index, originIndex) in indexArray.enumerated(){
            //指定值索引减去索引数组的索引
            let correctIndex = originIndex - index
            //添加到正确的索引数组中
            correctArray.append(correctIndex)
        }
        return correctArray
    }
    
    //从数组中删除指定元素
    mutating func removeValueFromArray<T: Equatable>(value: T){
        
        let correctArray = getRemoveIndex(value: value)
        //从原数组中删除指定元素
        for index in correctArray{
            self.remove(at: index)
        }
    }
}
