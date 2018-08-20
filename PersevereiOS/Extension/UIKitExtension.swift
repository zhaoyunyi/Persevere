//
//  UIKitExtension.swift
//  UIExtend
//
//  Created by zhaoyunyi on 2017/9/26.
//  Copyright © 2017年 fragment. All rights reserved.
//

import Foundation
import SnapKit
import SDWebImage

//MARK: UITextField
extension UITextField {
    var length: Int {
        get {
            return self.text?.count ?? 0
        }
    }
    func isEmpty() -> Bool {
        if self.text?.count == 0 || self.text == nil || self.text == "" {
            return true
        } else {
            return false
        }
    }

    func setPhoneNumberOnly() {
        self.clearButtonMode = UITextFieldViewMode.whileEditing
        self.keyboardType = UIKeyboardType.phonePad
    }
    func setNumberOnly() {
        self.clearButtonMode = UITextFieldViewMode.whileEditing
        self.keyboardType = UIKeyboardType.phonePad
    }
    func setSecured() {
        self.clearButtonMode = UITextFieldViewMode.whileEditing
        self.isSecureTextEntry = true
    }
    
    func setPhaceholderAttribut(placeholder: String, color: UIColor) {
        self.placeholder = placeholder
        let placeholder = NSMutableAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor: color])
        self.attributedPlaceholder = placeholder
    }
    
    func setLeftEmpty(width: CGFloat) {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: width, height: 25)
        
        self.leftView = view
        self.leftViewMode = .always
    }
    
    func setLeftLabel(string: String) {
        let leftLabel = UILabel()
        let view = UIView()
        leftLabel.text = string
        //        leftLabel.font = UIFont(name: PROJECT_VIEW_CH_FONT, size: 16)
        //        leftLabel.textColor = PROJECT_VIEW_BLACK444444
        let nsString = leftLabel.text ?? ""
        let lefitLabelSize = nsString.size(withAttributes: [NSAttributedStringKey.font: leftLabel.font])
        leftLabel.width = lefitLabelSize.width + 20
        leftLabel.height = lefitLabelSize.height
        view.width = lefitLabelSize.width + 20
        view.height = lefitLabelSize.height
        view.addSubview(leftLabel)
        leftLabel.textAlignment = .left
        leftLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(10)
            make.top.bottom.equalTo(view)
            make.width.equalTo(leftLabel.width)
        }
        
        self.leftView = view
        self.leftViewMode = .always
    }
    
    func setLeftImage(imageName: String) {
        let view = UIView()
        
        // 图片
        let image = UIImage(named: imageName)
        let leftImageView = UIImageView(image: image)
        let leftImageViewSize = CGSize(width: 16, height: 17)
        
        view.width = leftImageViewSize.width + 20
        view.height = leftImageViewSize.height
        
        view.addSubview(leftImageView)
        
        leftImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.top.bottom.equalTo(view)
            make.width.equalTo(leftImageViewSize)
        }
        
        self.leftView = view
        self.leftViewMode = .always
    }
}

//MARK: UIView
public extension UIView {
    
    public var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    
    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    public var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    public var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }

    public var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.x = newValue.x
            self.y = newValue.y
        }
    }
    
    public var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
    
    public func centerHorizontal(subView: UIView) -> CGRect {
        return self.centerHorizontal(yCoordinate: subView.y, widthOfSubView: width, heightOfSubView: height)
    }
    public func centerHorizontal(yCoordinate y: CGFloat, widthOfSubView width: CGFloat, heightOfSubView height: CGFloat) -> CGRect {
        var rectToReturn: CGRect = CGRect(x: 0, y: y, width: width, height: height)
        rectToReturn.origin.x = (self.width - width) / 2
        
        return rectToReturn
    }
    public class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

extension NSMutableAttributedString {
    class func getMutableAttributedString(contentString: String,allString: String,followText: String = "",color: UIColor, baseColor: UIColor) -> NSMutableAttributedString {
        
        let catString = NSMutableAttributedString(string: allString)
        catString.addAttribute(NSAttributedStringKey.foregroundColor, value: baseColor, range: NSMakeRange(0, allString.count))
        catString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: NSMakeRange(catString.length - contentString.count, contentString.count))
        
        let follow = NSMutableAttributedString(string: followText)
        follow.addAttribute(NSAttributedStringKey.foregroundColor, value: baseColor, range: NSMakeRange(0, followText.count))
        catString.append(follow)
        return catString
    }
    
    class func numberAttributed(numOne: Int, numTwo: Int ) -> NSMutableAttributedString {
        
        let color = mainBluePurple
        let font = UIFont.boldSystemFont(ofSize: 18)
        let oneNumStr = "\(numOne)/"
        let towNumStr = "\(numTwo)"
//        if numOne == 0 {
//            color = black333
//            font = UIFont.systemFont(ofSize: 14)
//            oneNumStr = "\(numOne)"
//            towNumStr = "/\(numTwo)"
//        }
        
        let colorAttribute = NSMutableAttributedString(string: oneNumStr,
            attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.font: font])
        let attribute = NSMutableAttributedString(string: towNumStr, attributes: [NSAttributedStringKey.foregroundColor : grayd5, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        colorAttribute.append(attribute)
        return colorAttribute
    }
    
    class func smallNumberAttributed(numOne: Int, numTwo: Int ) -> NSMutableAttributedString {
        
        let color = mainBluePurple
        let font = UIFont.boldSystemFont(ofSize: 14)
        let oneNumStr = "\(numOne)/"
        let towNumStr = "\(numTwo)"
        
        let colorAttribute = NSMutableAttributedString(string: oneNumStr,
                                                       attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.font: font])
        let attribute = NSMutableAttributedString(string: towNumStr, attributes: [NSAttributedStringKey.foregroundColor : grayd5, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        colorAttribute.append(attribute)
        return colorAttribute
    }
}

//MARK: - AttributedString
extension NSAttributedString {
    class func getAttributedString(contentString: String,allString: String,followText: String = "",color: UIColor, baseColor: UIColor) -> NSAttributedString {
        
        let catString = NSMutableAttributedString(string: allString)
        catString.addAttribute(NSAttributedStringKey.foregroundColor, value: baseColor, range: NSMakeRange(0, allString.count))
        catString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: NSMakeRange(catString.length - contentString.count, contentString.count))
        
        let follow = NSMutableAttributedString(string: followText)
        follow.addAttribute(NSAttributedStringKey.foregroundColor, value: baseColor, range: NSMakeRange(0, followText.count))
        catString.append(follow)
        return catString
    }
    
    class func getAttributedStringWithFont(contentString: String,allString: String,color: UIColor,font: UIFont) -> NSAttributedString {
        
        let catString = NSMutableAttributedString(string: allString)
        catString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: NSMakeRange(catString.length - contentString.count, contentString.count))
        
        catString.addAttribute(NSAttributedStringKey.font, value: font, range: NSMakeRange(catString.length - contentString.count, contentString.count))
        
        return catString
    }
    
    func heightWithConstrainedWidth(width: CGFloat, attributes : [NSAttributedStringKey : AnyObject]) -> CGFloat {
        let constraintRect = CGSize(width: self.widthWithStringAttributes(attributes: attributes, maxWidth: width), height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
    
    func widthWithStringAttributes(attributes : [NSAttributedStringKey : AnyObject], maxWidth: CGFloat) -> CGFloat {
        
        guard self.length > 0 else {
            return 0
        }
        let size = CGSize(width: maxWidth, height: 0)
        let text = NSString(format: "%@", self)
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.width
    }
}

func isShow3MultPicture() -> Bool {
    if ScreenHeight == 736.0 || ScreenHeight == 667.0 ||
        ScreenHeight == 414.0 {
        return true
    }
    
    return false
}

public extension UIButton {
    
    // 不按设备类型判断统一三倍-清晰一些
    func sd_fill_cutButton(urlStr: String, cutSize: CGSize) {
        let urlString = urlStr //urlStr.aliyunImageResize(size: cutSize)
        
        if let url = URL(string: urlString) {
            self.sd_setImage(with: url, for: UIControlState.normal)
        }
    }
    
    func sd_fill_cutButton(urlStr: String, cutSize: CGSize, placeholderImage: UIImage) {
        let urlString = urlStr.aliyunImageResize(size: cutSize)
        
        if let url = URL(string: urlString) {
            self.sd_setImage(with: url, for: UIControlState.normal, placeholderImage: placeholderImage)
        }
    }
    
    func sd_mfit_cutButton(urlStr: String, cutSize: CGSize, success: @escaping (_ image: UIImage?, _ error: Error?, _ type: SDImageCacheType, _ url: URL?) -> Void) {
        let urlString = urlStr.aliyunImageM_mfit(cutSize: cutSize)
        
        if let url = URL(string: urlString) {
            
            self.sd_setImage(with: url, for: .normal, completed: {
                (image: UIImage?, error: Error?, type: SDImageCacheType, url: URL?) in
                success(image, error, type, url)
            })
        }
    }
    
    func sd_mfit_cutButton(urlStr: String, cutSize: CGSize) {
        
        let urlString = urlStr.aliyunImageM_mfit(cutSize: cutSize)
        if let url = URL(string: urlString) {
            self.sd_setImage(with: url, for: .normal)
        }
    }
    
    func completeRightButton() {
        
        self.setTitle("完成", for: UIControlState.normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.frame = CGRect(x: 0, y: 0, width: 55, height: 30)
    }
}

public extension UIImage {
    func scaleToSize(size: CGSize) -> UIImage {
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size);
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
}

public extension UIImageView {
    
    public func sd_fill_cutImageSize50(urlStr: String) {
        let size = CGSize(width: 50, height: 50)
        self.sd_fill_cutImageView(urlStr: urlStr, cutSize: size)
    }
    
    public func sd_fill_cutImageSize60(urlStr: String) {
        let size = CGSize(width: 60, height: 60)
        self.sd_fill_cutImageView(urlStr: urlStr, cutSize: size)
    }
    
    public func sd_fill_cutImageSize180(urlStr: String) {
        let size = CGSize(width: 90, height: 90)
        self.sd_fill_cutImageView(urlStr: urlStr, cutSize: size)
    }
    // 不按设备类型判断统一三倍-清晰一些
    public func sd_fill_cutImageView(urlStr: String, cutSize: CGSize) {
        let urlString = urlStr.aliyunImageResize(size: cutSize)
        
        if let url = URL(string: urlString) {
//            self.sd_setImage(with: url)
            
            if let placeImage = UIImage(named: "placeholderHead") {
                self.sd_setImage(with: url, placeholderImage: placeImage)
            } else {
                self.sd_setImage(with: url)
            }
        }
    }
    
    public func sd_lfit_cutImageView(urlStr: String, cutSize: CGSize) {
        let urlString = urlStr.aliyunImageLfit(size: cutSize)
        
        if let url = URL(string: urlString) {
            self.sd_setImage(with: url)
        }
    }
    
    public func sd_mfit_cutImageView(urlStr: String, cutSize: CGSize) {
        let urlString = urlStr.aliyunImageM_mfit(cutSize: cutSize)
        
        if let url = URL(string: urlString) {
            self.sd_setImage(with: url)
        }
    }
    
}

public extension String {
    //    var URLEscaped: String {
    //        self.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()) ?? ""
    ////        return self.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()) ?? ""
    //    }
    // 拼接冰饭会对应的 阿里云截取图片的参数字符串 固定宽高，自动裁剪
    
    public func aliyunImageResize(size: CGSize) -> String {
        var height = size.height
        var width = size.width
        if isShow3MultPicture() {
            height = height * 3
            width = width * 3
        }else{
            height = height * 2
            width = width * 2
        }
        let str = (self as String) + "?x-oss-process=image/resize,m_fill,h_\(Int(height)),w_\(Int(width))"
        return str
    }
    
    public func aliyunImageLfit(size: CGSize) -> String {
        var height = size.height
        var width = size.width
        if isShow3MultPicture() {
            height = height * 3
            width = width * 3
        } else {
            height = height * 2
            width = width * 2
        }
        let str = self + "?x-oss-process=image/resize,m_lfit,h_\(Int(height)),w_\(Int(width))/format,png"
        return str
    }
    
    // 固定高度-按宽度 缩放 居中显示 http://image-demo-shanghai.oss-cn-jshanghai.aliyuncs.com/ft_example.jpg?x-oss-process=image/resize,m_lfit,h_400,limit_0/auto-orient,0/quality,q_90
    
    // 高度宽度等比例缩放 http://image-demo-shanghai.oss-cn-shanghai.aliyuncs.com/ft_example.jpg?x-oss-process=image/resize,m_fill,w_400,h_400,limit_0/auto-orient,0/quality,q_90
    public func aliyunImageM_mfit(cutSize: CGSize) -> String {
        var height = cutSize.height
        var width = cutSize.width
        if isShow3MultPicture() {
            height = height * 3
            width = width * 3
        } else {
            height = height * 2
            width = width * 2
        }
        let str = self + "?x-oss-process=image/resize,m_fill,h_\(Int(height)),w_\(Int(width)),limit_0/auto-orient,0/quality,q_100"
        return str
    }
    
    //返回第一次出现的指定子字符串在此字符串中的索引
    //（如果backwards参数设置为true，则返回最后出现的位置）
    func positionOf(sub:String, backwards:Bool = false)-> Int {
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
    
    //根据开始位置和长度截取字符串
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
}

//MARK: UIButton
extension UIButton {
    func setNormalTitle(title: String?) {
        self.setTitle(title, for: UIControlState.normal)
    }
    func setHighlightedTitle(title: String?) {
        self.setTitle(title, for: UIControlState.highlighted)
    }
    func setNormalTitleColor(color: UIColor?) {
        self.setTitleColor(color, for: UIControlState.normal)
    }
    func setHighlightedTitleColor(color: UIColor?) {
        self.setTitleColor(color, for: UIControlState.highlighted)
    }
    func setSystemFontSize(size: CGFloat) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: size)
    }
    func backItemButton() {
        let imageNormal = UIImage(named: "backnew")
        let imageClicked = UIImage(named: "backnew")
        self.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        self.setImage(imageNormal, for: UIControlState.normal)
        self.setImage(imageClicked, for: UIControlState.highlighted)
    }
    // 设置barItem
    func textDefaultItemButton(text: String) {
        self.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        self.setTitle(text, for: UIControlState.normal)
        self.setTitleColor(UIColor.colorWithHex(hex: 0x333333), for: UIControlState.normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel?.textAlignment = .right
    }
}

//MARK: - Properties
//MARK: UIColor
public extension UIColor {
    public convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    public convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    public static func RGBA (red r:CGFloat, green g:CGFloat, blue b:CGFloat, alpha a:CGFloat) -> UIColor {
        return UIColor(red: (r / 255.0), green: (g / 255.0), blue: (b / 255.0), alpha: a)
    }
    public static func RGB (red r: CGFloat, green g: CGFloat, blue b: CGFloat) -> UIColor {
        return UIColor.RGBA(red: r, green: g, blue: b, alpha:1)
    }
    
    public static func RGBS (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
        return UIColor (red: r, green: g, blue: b, alpha: a)
    }
    
    public static func colorWithHexAndAlpha(hex h: Int, alpha a: CGFloat) -> UIColor {
        let red = (CGFloat(((h & 0xFF0000) >> 16)))
        let green = (CGFloat(((h & 0xFF00) >> 8)))
        let blue = (CGFloat((h & 0xFF)))
        return UIColor.RGBA(red: red, green: green, blue: blue, alpha: a)
    }
    public static func colorWithHex(hex h: Int) -> UIColor {
        return UIColor.colorWithHexAndAlpha(hex: h, alpha: 1)
    }
    public class func silverColor() -> UIColor {
        return UIColor.colorWithHex(hex: 0xC0C0C0)
    }
    public class func skyBlueColor() -> UIColor {
        return UIColor.colorWithHex(hex: 0x87CEFA)
    }
    public class func LuoTianYi() -> UIColor {
        return UIColor.colorWithHex(hex: 0x66CCFF)
    }
    
    //返回随机颜色
    public class var randomColor: UIColor {
        get
        {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

