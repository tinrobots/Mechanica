//
//  NSObject+Swizzling.swift
//  Mechanica
//
//  Copyright © 2016-2017 Tinrobots.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

extension NSObject {

  /// **Mechanica**
  ///
  /// Couple of `Selector` where the method corresponding to the first one needs to be exchanged with the second one.
  public typealias swizzlingSelectors = (originaleSelector: Selector, swizzledSelector: Selector)

  /// **Mechanica**
  ///
  /// Exchanges the implementations of two methods given their corresponding selectors.
  /// To use method swizzling with your Swift classes there are two requirements that you must comply with:
  /// 1. The class containing the methods to be swizzled must extend **NSObject**.
  /// 1. The methods you want to swizzle must have the **dynamic** attribute.
  ///
  /// - Parameters:
  ///   - originalSelector: `Selector` for the original method
  ///   - swizzledSelector: `Selector` for the swizzled methos
  /// - Note: [Credits](https://www.uraimo.com/2015/10/23/effective-method-swizzling-with-swift/)
  public class func swizzle(method originalSelector: Selector, with swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(self, originalSelector)
    let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
    let isMethodAdded = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
    if isMethodAdded {
      class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
      method_exchangeImplementations(originalMethod, swizzledMethod)
    }
  }

  /// **Mechanica**
  ///
  /// Exchanges the implementations of each couple of Selectors.
  public class func swizzle(_ selectors: [swizzlingSelectors]){
    selectors.forEach { swizzle(method: $0.0, with: $0.1)}
  }

}