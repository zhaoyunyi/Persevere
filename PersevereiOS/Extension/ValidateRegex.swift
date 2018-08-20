//
//  ValidateRegex.swift
//  HYFinanceApp
//
//  Created by zhaoyunyi on 16/2/17.
//  Copyright © 2016年 zhaoyunyi. All rights reserved.
//

import Foundation
// "^[a-zA-Z0-9!\"#$%&'()*+,-./0:;<=>?@]{6,18}$" "^[a-zA-Z0-9!\"#$%&\'()*+,-./:;<=>?@\\^_`{|}~ /x20]{6,18}$"
// 正则判断

let phoneRegex = "^(0|86|17951)?^[1][0-9]{10}$" //"^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$"
let loginPasswordRegex = "[a-zA-Z0-9]{6,16}" //"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,12}$"//"^[\\x20-\\x7e]+$"
let verifyRegex = "^[0-9]{6}$"
let payPasswordRegex = "^[0-9]{6}$"
let realNameRegex = "^[a-zA-Z\\u4E00-\\u9FA5]{1,6}$"
let realIDRegex = "^[1-9][0-7]\\d{4}((19\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|(19\\d{2}(0[13578]|1[02])31)|(19\\d{2}02(0[1-9]|1\\d|2[0-8]))|(19([13579][26]|[2468][048]|0[48])0229))\\d{3}(\\d|X|x)?$"
let bankIDRegex = "^(\\d{16}|\\d{19})$"

let buyValueRegex = "^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){1,2})?$"

let httpRegex = "http(s)?://([a-zA-Z|\\d|[\\-]]+\\.)+[a-zA-Z|\\d|[\\-]]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?"

let carSerialRegex = "^(ZC)[0-9]{9}$"

let activityThemeRegex = "^[a-zA-Z\\u4E00-\\u9FA5 | [0-9]]{1,15}$"

let nameRegex = "^.{1,12}$"

public enum RegularPattern: String {
    //昵称
    case userNameRegex = "^[\\u4e00-\\u9fa5_a-zA-Z0-9]{1,12}$"
    //手机号
    case phone = "^1[3|4|5|7|8][0-9]\\d{8}$"
    // 密码
    case password = "[a-zA-Z0-9]{6,16}"
    //身份证号
    case IDNum = "\\d{14}[[0-9],0-9xX]"
    
    case normalPhone = "[0-9]{1,11}$"
}

struct RegexHelper {
    let regex: NSRegularExpression
    
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern:pattern,options: .caseInsensitive)
    }
    
    func match(_ input: String) -> Bool {
        let matches = regex.matches(in: input,options: [],range: NSMakeRange(0, input.utf16.count))
        return matches.count > 0
    }
    
    
    func matchCount(input: String) -> Int {
        
        let matches = regex.matches(in: input, options: [], range: NSMakeRange(0, input.utf16.count))
        return matches.count
    }
}

precedencegroup MatchPrecedence {
    associativity: none
    higherThan: DefaultPrecedence
}

infix operator =~: MatchPrecedence

public func =~(lhs: String, rhs: RegularPattern) -> Bool {
    do {
        return try RegexHelper(rhs.rawValue).match(lhs)
    } catch _ {
        return false
    }
}

func validateRegexMatches(regularExpression: NSRegularExpression, content: String) -> ([String], Bool) {
    let range = NSRange(location: 0, length: content.characters.count)
    let matches = regularExpression.matches(in: content, options: [], range: range)
    
    if matches.count == 0 {
        print("ERROR: line `\(content)` is invalid: \(regularExpression.pattern)")
        return ([], false)
    }
    
    for m in matches {
        if m.numberOfRanges == 0 || !NSEqualRanges(m.range, range) {
            print("ERROR: line `\(content)` is invalid: \(regularExpression.pattern)")
            return ([], false)
        }
    }
    
    return (matches[0 ..< matches.count].flatMap { m -> [String] in
        return (1 ..< m.numberOfRanges).map { index in
            return (content as NSString).substring(with: m.range(at: index))
        }
        }, true)
}
