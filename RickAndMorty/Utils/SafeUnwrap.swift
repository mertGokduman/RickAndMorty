//
//  SafeUnwrap.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 13.06.2022.
//

import Foundation
import UIKit

//SafeUnwrap Postfix Operator

postfix operator ~

postfix func ~ (_ val: Int?) -> Int {
    return safeUnwrap(val)
}

postfix func ~ (_ val: UInt?) -> UInt {
    return safeUnwrap(val)
}

postfix func ~ (_ val: Float?) -> Float {
    return safeUnwrap(val)
}

postfix func ~ (_ val: CGFloat?) -> CGFloat {
    return safeUnwrap(val)
}

postfix func ~ (_ val: Double?) -> Double {
    return safeUnwrap(val)
}

postfix func ~ (_ val: String?) -> String {
    return safeUnwrap(val)
}

postfix func ~ (_ val: Substring?) -> String {
    return safeUnwrap(val)
}

postfix func ~ (_ val: Bool?) -> Bool {
    return safeUnwrap(val)
}

postfix func ~ (_ val: Date?) -> Date? {
    return safeUnwrap(val)
}

postfix func ~ <T>(_ val: [T]?) -> [T] {
    return safeUnwrap(val)
}

postfix func ~ <T, U>(_ val: [T: U]?) -> [T: U] where T: Hashable {
    return safeUnwrap(val)
}

func safeUnwrap(_ integer: UInt?, default: UInt = 0) -> UInt {
    return integer ?? `default`
}

func safeUnwrap(_ integer: Int?, default: Int = 0) -> Int {
    return integer ?? `default`
}

func safeUnwrap(_ float: Float?, default: Float = 0) -> Float {
    return float ?? `default`
}

func safeUnwrap(_ cgfloat: CGFloat?, default: CGFloat = 0) -> CGFloat {
    return cgfloat ?? `default`
}

func safeUnwrap(_ double: Double?, default: Double = 0) -> Double {
    return double ?? `default`
}

func safeUnwrap(_ string: String?, default: String = "") -> String {
    return string ?? `default`
}

func safeUnwrap(_ substring: Substring?, default: Substring = "") -> String {
    return String(substring ?? `default`)
}

func safeUnwrap(_ bool: Bool?, default: Bool = false) -> Bool {
    return bool ?? `default`
}

func safeUnwrap(_ date: Date?, default: Date = Date()) -> Date {
    return date ?? `default`
}

func safeUnwrap<T>(_ array: [T]?, default: [T] = [T]()) -> [T] {
    return array ?? `default`
}

func safeUnwrap<T, U>(_ dictionary: [T: U]?, default: [T: U] = [T: U]()) -> [T: U] where T: Hashable {
    return dictionary ?? `default`
}
