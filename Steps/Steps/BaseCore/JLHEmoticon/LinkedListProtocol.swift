//
//  ChainTableProtocol.swift
//  Steps
//
//  Created by mathsandphysics on 2017/2/10.
//  Copyright © 2017年 Utopia. All rights reserved.
//

import Foundation

public protocol DoublyLinkedListProtocol {
    var linkId: String? { get set }
    var nextId: String? { get set }
    var lastId: String? { get set }
    mutating func linkNext<T: DoublyLinkedListProtocol>(_ next: inout T)
    mutating func linkLast<T: DoublyLinkedListProtocol>(_ last: inout T)
}

extension DoublyLinkedListProtocol {
    
    public mutating func linkNext<T: DoublyLinkedListProtocol>(_ next: inout T) {
        next.lastId = linkId
        nextId = next.linkId
    }
    
    public mutating func linkLast<T: DoublyLinkedListProtocol>(_ last: inout T) {
        lastId = last.linkId
        last.nextId = linkId
    }
}
