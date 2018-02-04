// 
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
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

class FontUtilsTests: XCTestCase {

  func testBold() {
    let font: Font
    #if os(macOS)
      font = Font.systemFont(ofSize: 16)
    #else
      font = Font.preferredFont(forTextStyle: .body)
    #endif

    let boldFont = font.bold()
    XCTAssertNotNil(boldFont)
    XCTAssertTrue(boldFont.isBold)
    XCTAssertFalse(boldFont.isItalic)
  }

  func testItalic() {
    let font: Font
    #if os(macOS)
      font = Font.systemFont(ofSize: 16)
    #else
      font = Font.preferredFont(forTextStyle: .body)
    #endif

    let italicFont = font.italic()
    XCTAssertTrue(italicFont.isItalic)
    XCTAssertFalse(italicFont.isBold)
  }

  func testBoldAndItalic() {
    let font: Font
    #if os(macOS)
      font = Font.systemFont(ofSize: 16)
    #else
      font = Font.preferredFont(forTextStyle: .body)
    #endif

    let boldAndItalicFont = font.bold().italic()
    XCTAssertTrue(boldAndItalicFont.isItalic)
    XCTAssertTrue(boldAndItalicFont.isBold)
  }


  func testIsBoldOrIsItalic() {

    #if !os(macOS)
      do {
        // Given
        let font = Font.preferredFont(forTextStyle: .headline) // this is bold by default

        // When, Then
        let italicAndBoldFont = font.italic()
        XCTAssertTrue(italicAndBoldFont.isBold)
        XCTAssertTrue(italicAndBoldFont.isItalic)

        // When, Then
        let onlyBoldFont = italicAndBoldFont.bold(removingExistingTraits: true)
        XCTAssertTrue(onlyBoldFont.isBold)
        XCTAssertFalse(onlyBoldFont.isItalic)

        // When, Then
        // The "Using Fonts With Text Kit" WWDC session sheds a bit of light on what might be happening here.
        // Around 18:00 in the video, slide 18 in the PDF a note is made that fontDescriptorWithSymbolicTraits: performs a font matching procedure internally.
        // It is only supposed to give you back a descriptor that will actually match a font.
        let onlyItalicFont = italicAndBoldFont.italic(removingExistingTraits: true)
        // there is no variant of the headline font that is italic but not bold.
        XCTAssertTrue(onlyItalicFont.isBold)
        XCTAssertTrue(onlyItalicFont.isItalic)
      }
    #endif

    do {
      // Given
      let font = Font.systemFont(ofSize: 16)
      XCTAssertFalse(font.isBold)
      XCTAssertFalse(font.isItalic)

      // When, Then
      let italicAndBoldFont = font.italic().bold()
      XCTAssertTrue(italicAndBoldFont.isBold)
      XCTAssertTrue(italicAndBoldFont.isItalic)

      // When, Then
      let onlyBoldFont = italicAndBoldFont.bold(removingExistingTraits: true)
      XCTAssertTrue(onlyBoldFont.isBold)
      XCTAssertFalse(onlyBoldFont.isItalic)

      // When, Then
      let onlyItalicFont = italicAndBoldFont.italic(removingExistingTraits: true)
      XCTAssertFalse(onlyItalicFont.isBold) //
      XCTAssertTrue(onlyItalicFont.isItalic)
    }
  }


}
