//
// Mechanica
//
// Copyright © 2016-2019 Tinrobots.
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

extension UserDefaultsUtilsTests {
  @available(iOS 11, tvOS 11, watchOS 4, macOS 10.13, *)
  static var allTests = [
    ("testOptionalInteger", testOptionalInteger),
    ("testOptionalDouble", testOptionalDouble),
    ("testOptionalFloat", testOptionalFloat),
    ("testOptionalBool", testOptionalBool),
    ("testRemoveAll", testRemoveAll),
  ]
}

final class UserDefaultsUtilsTests: XCTestCase {

  let suiteName = "UserDefaultsUtilsTests"
  var testDefaults: UserDefaults!

  override func setUp() {
    super.setUp()
    testDefaults = UserDefaults(suiteName: suiteName)!
  }

  override func tearDown() {
    UserDefaults().removePersistentDomain(forName: suiteName)
    super.tearDown()
  }

  func testOptionalInteger() {
    let userDefaults = testDefaults!
    let key = "\(#function)-\(#line)-\(UUID().uuidString)"
    XCTAssertFalse(userDefaults.hasKey(key))

    userDefaults.set(10, forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalInteger(forKey: key))
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), 10)

    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), .none)
    #endif

    userDefaults.set(10, forKey: key)
    userDefaults.removeObject(forKey: key)
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), .none)

    userDefaults.set("hello world", forKey: key)
    XCTAssertEqual(userDefaults.optionalInteger(forKey: key), .none)
  }

  func testOptionalDouble() {
    let userDefaults = testDefaults!
    let key = "\(#function)-\(#line)-\(UUID().uuidString)"
    XCTAssertFalse(userDefaults.hasKey(key))

    userDefaults.set(Double(10), forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalDouble(forKey: key))
    XCTAssertEqual(userDefaults.optionalDouble(forKey: key), Double(10))

    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalDouble(forKey: key), .none)
    #endif

    userDefaults.set("hello world", forKey: key)
    XCTAssertEqual(userDefaults.optionalDouble(forKey: key), .none)
  }

  func testOptionalFloat() {
    let userDefaults = testDefaults!
    let key = "\(#function)\(#line)-\(UUID().uuidString)"
    XCTAssertFalse(userDefaults.hasKey(key))

    userDefaults.set(10.1, forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalFloat(forKey: key))
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), 10.1)

    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    userDefaults.set(nil, forKey: key)
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), .none)
    #endif

    userDefaults.set("hello world", forKey: key)
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), .none)
  }

  func testOptionalBool() {
    let userDefaults = testDefaults!
    let key = "\(#function)-\(#line)-\(UUID().uuidString)"
    XCTAssertFalse(userDefaults.hasKey(key))

    userDefaults.set(true, forKey: key)
    XCTAssertTrue(userDefaults.hasKey(key))
    XCTAssertNotNil(userDefaults.optionalBool(forKey: key))
    XCTAssertEqual(userDefaults.optionalBool(forKey: key), true)

    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), 1)
    userDefaults.set(nil, forKey: key) // TODO: setting a value to nil crash on Linux (Swift 4.2 and Swift 5)
    XCTAssertEqual(userDefaults.optionalBool(forKey: key), nil)
    XCTAssertEqual(userDefaults.optionalFloat(forKey: key), .none)
    #endif

    userDefaults.set("hello world", forKey: key)
    XCTAssertEqual(userDefaults.optionalBool(forKey: key), .none)
  }

  func testRemoveAll() {
    let userDefaults = testDefaults!
    let key = "\(#function)-\(#line)-\(UUID().uuidString)"
    XCTAssertFalse(userDefaults.hasKey(key))

    userDefaults.set(10, forKey: key)
    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    XCTAssertNotNil(userDefaults.value(forKey: key))
    #endif
    XCTAssertNotNil(userDefaults.integer(forKey: key))

    let key2 = UUID().uuidString
    XCTAssertFalse(userDefaults.hasKey(key2))

    userDefaults.set(Double(10), forKey: key2)
    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    XCTAssertNotNil(userDefaults.value(forKey: key2))
    #endif
    XCTAssertNotNil(userDefaults.double(forKey: key))

    let key3 = UUID().uuidString
    XCTAssertFalse(userDefaults.hasKey(key3))

    userDefaults.set(10.0, forKey: key3)
    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    XCTAssertNotNil(userDefaults.value(forKey: key3))
    #endif
    XCTAssertNotNil(userDefaults.double(forKey: key3))

    userDefaults.removeAll()

    #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    XCTAssertNil(userDefaults.value(forKey: key))
    XCTAssertNil(userDefaults.value(forKey: key2))
    XCTAssertNil(userDefaults.value(forKey: key3))
    #endif

    XCTAssertNil(userDefaults.optionalInteger(forKey: key))
    XCTAssertNil(userDefaults.optionalDouble(forKey: key2))
    XCTAssertNil(userDefaults.optionalDouble(forKey: key3))

    XCTAssertFalse(userDefaults.hasKey(key))
    XCTAssertFalse(userDefaults.hasKey(key2))
    XCTAssertFalse(userDefaults.hasKey(key3))
  }

}
