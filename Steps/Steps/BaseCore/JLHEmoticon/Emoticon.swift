//
//  Emoticon.swift
//  Steps
//
//  Created by mathsandphysics on 2017/2/4.
//  Copyright © 2017年 Utopia. All rights reserved.
//

import UIKit

public func codeTransferToEmojiCode(_ code: String?) -> String? {
    
    guard code != nil && code!.characters.count > 0 else {
        return nil
    }
    // 1.创建扫描器
    let scanner = Scanner(string: code!)
    
    // 2.调用方法,扫描出code中的值
    var value : UInt32 = 0
    scanner.scanHexInt32(&value)
    
    // 3.将value转成字符
    let c = Character(UnicodeScalar(value)!)
    
    // 4.将字符转成字符串
    return String(c)
}

public func emojiCodeTransferToCode(_ emojiCode: String?) -> String? {
    guard emojiCode != nil && emojiCode!.characters.count > 0 else {
        return nil
    }
    assertionFailure("code转成emojiCode未实现")
    return nil
}

class Emoticon: NSObject {
    
    /** emoji表情的编码 */
    var code: String?
    var imageName: String?
    /** emoji表情的文字描述 */
    var chs: String?
    /** 表情id */
    var eid: String?
    /** 对应的表情包id */
    var packid: String?
    /** 表情的时间戳 */
    var timeStamp: String?
    /** 单个表情的url */
    var url: String?
    
    // MARK:- DoublyLinkedListProtocol
    var linkId: String?
    var nextId: String?
    var lastId: String?
    
    init(dict: [String : String]) {
        super.init()
        setValuesForKeys(dict)
        linkId = eid
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    var emojiCode: String? {
        get {
            return codeTransferToEmojiCode(code)
        }
        set {
            self.code = emojiCodeTransferToCode(newValue)
        }
    }
    
    var localPath: String? {
        guard (imageName != nil && imageName!.characters.count > 0) else {
            return nil
        }
        return Bundle.main.bundlePath + "/Emoticons.bundle/" + imageName!
    }
}

extension Emoticon: DoublyLinkedListProtocol {}


