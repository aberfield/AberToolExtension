//
//  Array.swift
//  BSTrade
//
//  Created by duxin on 20/03/2017.
//  Copyright © 2017 BST. All rights reserved.
//

import Foundation

extension Array {
    
    subscript(safe index: Int)->Element?{
        return outOfbound(index: index) ? nil : self[index]
    }
    
    @discardableResult mutating func removeSafe(at index: Int) -> Element?{
        return outOfbound(index: index) ? nil : remove(at: index)
    }
    
    mutating func insertSafe(_ newElement:Element, at index: Int){
        if !outOfbound(index: index - 1){
            self.insert(newElement, at: index)
        }
    }
    
    private func outOfbound(index: Int) -> Bool{
        if index >= count{
            #if DEBUG
                assertionFailure("Get value at (\(index)) out of bound \(count).")
            #endif
            return true
        }
        return false
    }

}


extension Array where Element: BinaryInteger {

    /// 数组求和
    var sumOfElements: Element {
        return reduce(0, +)
    }
}

extension Array where Element: Equatable {

    /// 数组去重
    mutating func removeDuplicateElements() {
        self = self.reduce([]){ $0.contains($1) ? $0 : $0 + [$1] }
    }
}
