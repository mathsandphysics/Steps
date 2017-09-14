//
//  EmoticonPackage.swift
//  Steps
//
//  Created by mathsandphysics on 2017/2/4.
//  Copyright © 2017年 Utopia. All rights reserved.
//

import UIKit

enum EmoticonPackageShelfState {
    case on_shelf, off_shelf
}

class EmoticonPackage: NSObject {
    
    /** 表情数组 */
    var emoticons : [Emoticon] = [Emoticon]()
    /** 表情包Id*/
    var packageId: String?
    /** 表情包名称*/
    var packageName: String?
    /** 表情包简介 */
    var summary: String?
    /** 表情包创建时间 */
    var createTime: Int?
    /** 下载路径 */
    var url: String?
    /** 表情包状态 1. 上架，2. 下架 */
    var state: Int?
    /** 存储路径 */
    var packagePath: String?
    
    func getEmoticon<T>(property: String, value: T, closure: (T, T) -> Bool) -> Emoticon? {
        for emoticon in emoticons {
            if closure(emoticon.value(forKey: property) as! T, value) {
                return emoticon
            }
        }
        return nil
    }
    
    func insertEmoticon(emoticon: inout Emoticon, index: Int) {
        guard index < emoticons.count && index >= 1 else {
            assertionFailure("insertEmoticon -- emojicons数组越界")
            return
        }
        var lastEmoticon = emoticons[index-1]
        emoticons.insert(emoticon, at: index)
        combine(first: &lastEmoticon, second: &emoticon)
        
        if index+1 < emoticons.count {
            var nextEmoticon = emoticons[index+1]
            combine(first: &emoticon, second: &nextEmoticon)
        } else {
            emoticon.nextId = nil
        }
    }
    
    func removeEmoticon(index: Int) {
        guard index < emoticons.count && index >= 1 else {
            assertionFailure("removeEmoticon -- emojicons数组越界")
            return
        }
        var lastEmoticon = emoticons[index-1]
        if index+1 < emoticons.count {
            var nextEmoticon = emoticons[index+1]
            emoticons.remove(at: index)
            combine(first: &lastEmoticon, second: &nextEmoticon)
        } else {
            lastEmoticon.nextId = nil
        }
    }
    
    func combine( first: inout Emoticon, second: inout Emoticon) {
        first.nextId = second.eid
        second.lastId = first.eid
    }
}
