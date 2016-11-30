//
//  StringExtensionTests.swift
//  Mechanica
//
//  Copyright © 2016 Tinrobots.
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

import XCTest
@testable import Mechanica

class StringUtilsTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_length() {
    XCTAssertTrue("".length == 0)
    XCTAssertTrue(" ".length == 1)
    XCTAssertTrue("cafe".length == 4)
    XCTAssertTrue("cafè".length == 4)
    XCTAssertTrue("🇮🇹".length == 1)
    XCTAssertTrue("🇮🇹🇮🇹".length == 1)
    XCTAssertTrue("🇮🇹 🇮🇹".length == 3)
    XCTAssertTrue("👍🏻".length > 1) //2
    XCTAssertTrue("👍🏽".length > 1) //2
    XCTAssertTrue("👨‍👨‍👧‍👦".length > 1) //4
  }
  
  func test_starts() {
    //case sensitive
    XCTAssertTrue("a".starts(with:"a"))
    XCTAssertFalse("a".starts(with:"A"))
    XCTAssertTrue("🤔a1".starts(with:"🤔"))
    XCTAssertTrue("🖖🏽a1".starts(with:"🖖🏽"))
    XCTAssertTrue("🇮🇹🇮🇹🖖🏽 ".starts(with:"🇮🇹"))
    
    //case insensitive
    XCTAssertTrue("🇮🇹🇮🇹🖖🏽 ".starts(with:"🇮🇹", caseSensitive: false))
    XCTAssertTrue("a".starts(with:"A", caseSensitive: false))
    XCTAssertTrue("Hello".starts(with:"hello", caseSensitive: false))
    XCTAssertFalse("Hello".starts(with:"helloo", caseSensitive: false))
  }
  
  func test_reversed() {
    XCTAssertTrue("a".reversed() == "a")
    XCTAssertTrue("aa".reversed() == "aa")
    XCTAssertTrue("abc".reversed() == "cba")
    XCTAssertTrue("🤔aa".reversed() == "aa🤔")
  }
  
  func test_contains_caseSensitive() {
    XCTAssertTrue("AaBbCc".contains("a", caseSensitive: true))
    XCTAssertTrue("AaBbCc".contains("Aa", caseSensitive: true))
    
    XCTAssertFalse("AaBbCc".contains("aa", caseSensitive: true)) //case sensitive
    XCTAssertTrue("AaBbCc".contains("aa", caseSensitive: false)) //case insensitive
    XCTAssertTrue("AaBbCc".contains("Aa", caseSensitive: true)) //case sensitive
    XCTAssertFalse("AaBbCc".contains("aa", caseSensitive: true)) //case sensitive
    
    XCTAssertFalse("HELLO world".contains("hello", caseSensitive: true)) //case sensitive
    XCTAssertTrue("HELLO world".contains("hello", caseSensitive: false)) //case insensitive
    
    XCTAssertTrue("AaB🤔bCc".contains("🤔", caseSensitive: true))
    XCTAssertFalse("AaB🤔bCc".contains("🤔🤔", caseSensitive: true))
    XCTAssertTrue("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".contains("ta", caseSensitive: true))
    XCTAssertTrue("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".contains("\u{200B}", caseSensitive: true))
    XCTAssertTrue("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".contains("🇮🇹", caseSensitive: true))
    XCTAssertTrue("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".contains("🇮🇹", caseSensitive: false))
    XCTAssertFalse("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".contains("{20", caseSensitive: true))
  }
  
  func test_replace() {
    XCTAssertTrue("AaBbCc".replace("a", with: "Z") == "AZBbCc")
    XCTAssertTrue("AaBbCc".replace("a", with: "a") == "AaBbCc")
    XCTAssertFalse("AaBbCc".replace("a", with: "A") == "AaBbCc")
    XCTAssertTrue("AaBbCc".replace("", with: "A") == "AaBbCc")
    XCTAssertTrue("AaBbCc".replace("AaBbCc", with: "123") == "123")
    XCTAssertTrue("aaBbCa".replace("a", with: "1") == "11BbC1")
    
    XCTAssertTrue("AaBbCc🤔".replace("🤔", with: "🤔🤔") == "AaBbCc🤔🤔")
    XCTAssertTrue("".replace("🤔", with: "🤔🤔") == "")
    XCTAssertTrue("".replace("", with: "🤔") == "")
    
    XCTAssertTrue("Italy 🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹".replace("\u{200B}", with: " ") == "Italy 🇮🇹 🇮🇹 🇮🇹")
    
    XCTAssertTrue("AaBbCc".replace("a", with: "Z", caseSensitive: false) == "ZZBbCc")
    XCTAssertTrue("AaBbCc".replace("a", with: "a", caseSensitive: false) == "aaBbCc")
    XCTAssertTrue("AaBbCc".replace("a", with: "A", caseSensitive: false) == "AABbCc")
    XCTAssertTrue("AaBbCc".replace("", with: "A", caseSensitive: false) == "AaBbCc")

    
  }
  
  func test_trim() {
    var s1 = "   Hello World   "
    s1.trim()
    XCTAssertTrue(s1 == "Hello World")
  }
  
  func test_trimmed() {
    let s1 = "   Hello World   "
    XCTAssertTrue(s1.trimmedLeft() == "Hello World   ")
    XCTAssertTrue(s1.trimmedRight() == "   Hello World")
    XCTAssertTrue(s1.trimmed() == "Hello World")
    
    let s2 = "   \u{200B} Hello World   "
    XCTAssertTrue(s2.trimmedLeft() == "Hello World   ")
    XCTAssertTrue(s2.trimmed() == "Hello World")
    
    let s3 = "Hello World\n\n   "
    XCTAssertTrue(s3.trimmedRight() == "Hello World")
    XCTAssertTrue(s3.trimmed() == "Hello World")
    
    
    let s4 = "abcdefg"
    XCTAssertTrue(s4.trimmedRight(characterSet: NSCharacterSet.alphanumerics) == "")
    XCTAssertTrue(s4.trimmedLeft(characterSet: NSCharacterSet.alphanumerics) == "")
    
    let s5 = "  abcdefg  "
    XCTAssertTrue(s5.trimmedRight(characterSet: NSCharacterSet.alphanumerics) == "  abcdefg  ")
    XCTAssertTrue(s5.trimmedLeft(characterSet: NSCharacterSet.alphanumerics) == "  abcdefg  ")
    XCTAssertTrue(s5.trimmed() == "abcdefg")
    
  }
  
  func test_capitalizedFirst() {
    let s1 = "   hello world   "
    XCTAssertTrue(s1.capitalizedFirst() == s1)
    let s2 = "hello world   "
    XCTAssertTrue(s2.capitalizedFirst() == "Hello world   ")
    let s3 = "1 hello world   "
    XCTAssertTrue(s3.capitalizedFirst() == s3)
    let s4 = "🇮🇹 hello world   "
    XCTAssertTrue(s4.capitalizedFirst() == s4)
    let s5 = "🇮🇹🇮🇹 hello world   "
    XCTAssertTrue(s5.capitalizedFirst() == s5)
    let s6 = "Hello world   "
    XCTAssertTrue(s6.capitalizedFirst() == s6)
    let s7 = "\na"
    XCTAssertTrue(s7.capitalizedFirst() == s7)
    let s8 = ""
    XCTAssertTrue(s8.capitalizedFirst() == s8)
    let s9 = "h e l l o w o r l d"
    XCTAssertTrue(s9.capitalizedFirst() == "H e l l o w o r l d")
    let s10 = "\u{200B}hello\u{200B}"
    XCTAssertTrue(s10.capitalizedFirst() == s10)
  }
  
  func test_prefix() {
    let s = "Hello World 🖖🏽"
    XCTAssertTrue(s.prefix(maxLength: -100) == "")
    XCTAssertTrue(s.prefix(maxLength: 0) == "")
    XCTAssertTrue(s.prefix(maxLength: 1) == "H")
    XCTAssertTrue(s.prefix(maxLength: 2) == "He")
    XCTAssertTrue(s.prefix(maxLength: 3) == "Hel")
    XCTAssertTrue(s.prefix(maxLength: 4) == "Hell")
    XCTAssertTrue(s.prefix(maxLength: 5) == "Hello")
    XCTAssertTrue(s.prefix(maxLength: 6) == "Hello ")
    XCTAssertTrue(s.prefix(maxLength: 13) == "Hello World 🖖")
    XCTAssertTrue(s.prefix(maxLength: 14) == "Hello World 🖖🏽")
    XCTAssertTrue(s.prefix(maxLength: 100) == "Hello World 🖖🏽")
  }
  
  func test_suffix() {
    let s = "Hello World 🖖🏽"
    XCTAssertTrue(s.suffix(maxLength: -100) == "")
    XCTAssertTrue(s.suffix(maxLength: 0) == "")
    XCTAssertTrue(s.suffix(maxLength: 1) == "🏽")
    XCTAssertTrue(s.suffix(maxLength: 2) == "🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 3) == " 🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 4) == "d 🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 5) == "ld 🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 6) == "rld 🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 13) == "ello World 🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 14) == "Hello World 🖖🏽")
    XCTAssertTrue(s.suffix(maxLength: 100) == "Hello World 🖖🏽")
  }
  
  func test_condensingExcessiveSpaces() {
    XCTAssertTrue("test spaces too many".condensingExcessiveSpaces() == "test spaces too many")
    XCTAssertTrue("test  spaces    too many".condensingExcessiveSpaces() == "test spaces too many")
    XCTAssertTrue(" test spaces too many ".condensingExcessiveSpaces() == "test spaces too many")
    XCTAssertTrue(" test spaces too many".condensingExcessiveSpaces() == "test spaces too many")
    XCTAssertTrue("test spaces too many ".condensingExcessiveSpaces() == "test spaces too many")
  }
  
  func test_condensingExcessiveSpacesAndNewLines() {
    XCTAssertTrue("test\n spaces too many".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
    XCTAssertTrue("\n\ntest  spaces    too many".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
    XCTAssertTrue(" test spaces too many \n\n".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
    XCTAssertTrue(" test spaces too\n many".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
    XCTAssertTrue("test\n\n spaces \n\n too many ".condensingExcessiveSpacesAndNewlines() == "test spaces too many")
  }
  
  func test_first(){
    let s = "Hello"
    XCTAssertTrue(s.first == "H")
  }
  
  
  func test_last(){
    let s = "Hello"
    XCTAssertTrue(s.last == "o")
  }
  
  func test_removingPrefix() {
    
    let s = "hello"
    XCTAssertTrue(s.removingPrefix(upToPosition: 0) == "hello")
    XCTAssertTrue(s.removingPrefix() == "ello")
    XCTAssertTrue(s.removingPrefix(upToPosition: 1) == "ello")
    XCTAssertTrue(s.removingPrefix(upToPosition: 3) == "lo")
    XCTAssertTrue(s.removingPrefix(upToPosition: 5) == "")
    XCTAssertTrue(s.removingPrefix(upToPosition: 100) == "")
    XCTAssertTrue(s.removingPrefix(upToPosition: -1) == "")
    
    XCTAssertTrue("".removingPrefix(upToPosition: 1) == "")
    
  }
  
  
  func test_removingSuffix() {
    
    let s = "hello"
    XCTAssertTrue(s.removingSuffix(fromPosition: 0) == "hello")
    XCTAssertTrue(s.removingSuffix() == "hell")
    XCTAssertTrue(s.removingSuffix(fromPosition: 1) == "hell")
    XCTAssertTrue(s.removingSuffix(fromPosition: 3) == "he")
    XCTAssertTrue(s.removingSuffix(fromPosition: 5) == "")
    XCTAssertTrue(s.removingSuffix(fromPosition: 100) == "")
    XCTAssertTrue(s.removingSuffix(fromPosition: -1) == "")
    
    XCTAssertTrue("".removingSuffix(fromPosition: 1) == "")
    
  }
  
  func test_truncate() {
    let s = "Hello World"
    
    XCTAssertTrue(s.truncate(at: 0) == "…")
    XCTAssertTrue(s.truncate(at: 0, withTrailing: nil) == "")
    XCTAssertTrue(s.truncate(at: 5) == "Hello…")
    XCTAssertTrue(s.truncate(at: -5) == "")
    XCTAssertTrue(s.truncate(at: 10) == "Hello Worl…")
    XCTAssertTrue(s.truncate(at: 10, withTrailing: nil) == "Hello Worl")
    XCTAssertTrue(s.truncate(at: 11) == "Hello World")
    XCTAssertTrue(s.truncate(at: 11,withTrailing: nil) == "Hello World")
    XCTAssertTrue(s.truncate(at: 100) == "Hello World")
    
    let s2 = "Hello 🗺"
    XCTAssertTrue(s2.truncate(at: 5) == "Hello…")
    XCTAssertTrue(s2.truncate(at: 6) == "Hello …")
    XCTAssertTrue(s2.truncate(at: 7) == "Hello 🗺")
    
    let s3 = "a😀bb😄😄ccc😄😬😄"
    XCTAssertTrue(s3.truncate(at: 0) == "…")
    XCTAssertTrue(s3.truncate(at: 1) == "a…")
    XCTAssertTrue(s3.truncate(at: 2) == "a😀…")
    XCTAssertTrue(s3.truncate(at: 3) == "a😀b…")
    XCTAssertTrue(s3.truncate(at: 4) == "a😀bb…")
    XCTAssertTrue(s3.truncate(at: 5) == "a😀bb😄…")
    XCTAssertTrue(s3.truncate(at: 6) == "a😀bb😄😄…")
    
    let s4 = "a🇮🇹bb🇮🇹🇮🇹ccc🇮🇹🇮🇹🇮🇹"
    XCTAssertTrue(s4.truncate(at: 0) == "…")
    XCTAssertTrue(s4.truncate(at: 1) == "a…")
    XCTAssertTrue(s4.truncate(at: 2) == "a🇮🇹…")
    XCTAssertTrue(s4.truncate(at: 3) == "a🇮🇹b…")
    XCTAssertTrue(s4.truncate(at: 4) == "a🇮🇹bb…")
    //Multiple emoji flags are counted as 1 character: "🇮🇹🇮🇹".characters.count is 1
    //Swift can't understand them without a separation character.
    //(http://stackoverflow.com/questions/26862282/swift-countelements-return-incorrect-value-when-count-flag-emoji)
    XCTAssertTrue(s4.truncate(at: 5) == "a🇮🇹bb🇮🇹🇮🇹…")
    XCTAssertTrue(s4.truncate(at: 6) == "a🇮🇹bb🇮🇹🇮🇹c…")
    
    let s5 = "\u{2126}"
    XCTAssertTrue(s5.truncate(at: 0) == "…")
    XCTAssertTrue(s5.truncate(at: 4) == "Ω")
    XCTAssertTrue(s5.truncate(at: 100) == "Ω")
    
    let s6 = "cafè"
    XCTAssertTrue(s6.truncate(at: 1) == "c…")
    XCTAssertTrue(s6.truncate(at: 4) == "cafè")
    
    let s7 = "👍👍👍👍" // 4 characters
    XCTAssertTrue(s7.truncate(at: 1) == "👍…")
    XCTAssertTrue(s7.truncate(at: 2) == "👍👍…")
    XCTAssertTrue(s7.truncate(at: 3) == "👍👍👍…")
    
    let s8 = "👍👍🏻👍🏼👍🏾" // 7 characters (4x👍 + 3 skin tone)
    XCTAssertTrue(s8.truncate(at: 1) == "👍…")
    XCTAssertTrue(s8.truncate(at: 2) == "👍👍…") //skin tone truncated
    XCTAssertTrue(s8.truncate(at: 3) == "👍👍🏻…")
    XCTAssertTrue(s8.truncate(at: 4) == "👍👍🏻👍…") //skin tone truncated
    XCTAssertTrue(s8.truncate(at: 5) == "👍👍🏻👍🏼…")
    
    //flags sperated by a ZERO WIDTH SPACE
    let s9 = "🇮🇹\u{200B}🇮🇹\u{200B}🇮🇹"
    XCTAssertTrue(s9.truncate(at: 1) == "🇮🇹…")
    XCTAssertTrue(s9.truncate(at: 2) == "🇮🇹​…")
    XCTAssertTrue(s9.truncate(at: 3) == "🇮🇹​🇮🇹…")
    XCTAssertTrue(s9.truncate(at: 4) == "🇮🇹​🇮🇹​…")
    XCTAssertTrue(s9.truncate(at: 5) == "🇮🇹​🇮🇹​🇮🇹")
    
  }
  
  func test_subscript() {
    let string = "∆Test😗"
    
    XCTAssertTrue(string[0] == "∆")
    XCTAssertTrue(string[1] == "T")
    
    XCTAssertNil(string[-1])
    XCTAssertNil(string[6])
    XCTAssertNil(string[10])
    
    XCTAssertTrue(string[string.length - 1] == "😗")
    
    XCTAssertTrue(string[0..<1] == "∆")
    XCTAssertTrue(string[1..<6] == "Test😗")
    
    XCTAssertNotNil(string["Test"])
    XCTAssertNotNil(string["😗"])
    
    
    //MARK: Range
    
    XCTAssertTrue(string[Range(0..<3)] == "∆Te")
    XCTAssertTrue(string[Range(3..<3)] == "")
    XCTAssertTrue(string[Range(3..<6)] == "st😗")
    XCTAssertTrue(string[Range(0..<string.length)] == "∆Test😗")
    
    //XCTAssertNil(string[Range(string.length+1 ..< string.length)])
    XCTAssertNil(string[Range(string.length ..< string.length+1)])
    XCTAssertTrue(string[Range(string.length ..< string.length)] == "")
    
    XCTAssertNil(string[Range(1 ..< 100)])
    
    XCTAssertNil(string[Range(-1 ..< 1)])
    
    XCTAssertNil(string[Range(1 ..< string.length+1)])
    
    XCTAssertNil(string[Range(100 ..< 200)])
    
    XCTAssertNil(string[Range(-1 ..< string.length)])
    
    XCTAssertNil(string[Range(-1 ..< 1)])
    
    XCTAssertNil(string[Range(string.length+10 ..< string.length+10)])
    
    //MARK: NSRange
    
    let nsrange = NSRange(location: 0, length: 1)
    XCTAssertTrue(string[nsrange] == "∆")
    
    let nsrange2 = NSRange(location: 4, length: 2)
    XCTAssertTrue(string[nsrange2] == "t😗")
    
    let nsrange3 = NSRange(location: 40, length: 2)
    XCTAssertNil(string[nsrange3])
    
    let nsrange4 = NSRange(location: -1, length: 2)
    XCTAssertNil(string[nsrange4])
    
    XCTAssertNil(string[""])
    let range2 = string["∆"]
    XCTAssertTrue(range2! == string.startIndex ..< string.index(string.startIndex, offsetBy: 1))
    let range3 = string["est"] //2,3,4
    XCTAssert(range3! ~= string.index(string.startIndex, offsetBy: 2) ..< string.index(string.startIndex, offsetBy: 5))
    XCTAssertNil(string["k"])
    XCTAssertNil(string["123est"])
  }
  
  func test_replacingCharacters() {
    
    let s = "Hello World" //10 characters
    do{
      let countableRange = CountableRange(uncheckedBounds: (lower: 0, upper: 2)) //[0,2[
      let newString = s.replacingCharacters(in: countableRange, with: "1")
      XCTAssertTrue(newString == "1llo World")
      
      let countableClosedRange = CountableClosedRange(uncheckedBounds: (lower: 0, upper: 2)) //[0,2]
      let newString2 = s.replacingCharacters(in: countableClosedRange, with: "1")
      XCTAssertTrue(newString2 == "1lo World")
    }
    do{
      let countableRange = CountableRange(uncheckedBounds: (lower: 0, upper: 11)) //[0,11[
      let newString = s.replacingCharacters(in: countableRange, with: "1")
      XCTAssertTrue(newString == "1")
      
      let countableClosedRange = CountableClosedRange(uncheckedBounds: (lower: 0, upper: s.characters.count-1)) //[0,9]
      let newString2 = s.replacingCharacters(in: countableClosedRange, with: "1")
      XCTAssertTrue(newString2 == "1")
    }
    
  }
  
}

