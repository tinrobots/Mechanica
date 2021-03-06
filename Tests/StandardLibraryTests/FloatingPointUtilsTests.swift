import XCTest
@testable import Mechanica

extension FloatingPointUtilsTests {
  static var allTests = [
    ("testRounding", testRounding),
    ("testCeiling", testCeiling),
    ("testFlooring", testFlooring)
  ]
}

final class FloatingPointUtilsTests: XCTestCase {

  func testRounding() {
    var piFloat         = Float(3.141_592_653_589_793_238_46)   //  3.14159274
    var piDouble        = 3.14159_26535_89793_23846             //  3.1415926535897931
    var piFloat80       = Float80(3.14159_26535_89793_23846)    //  3.141592653589793116

    var negativeDouble  = -147.956455                           //  -147.95645500000001
    var randomFloat     = Float32(199.959019)                    //  199.959015
    var bigFloat        = Float80(0.9278766111959092165201989)  //  0.927876611195909251073

    XCTAssertEqual(0.5.rounded(to: 0), 1)
    XCTAssertEqual(piFloat.rounded(to: 0), 3.0)
    XCTAssertEqual(piFloat.rounded(to: -1), 3.14159274)
    XCTAssertTrue((piFloat.rounded(to: 1000)).isNaN)

    XCTAssertEqual(piFloat.rounded(to: 7), 3.1415927)
    XCTAssertEqual(piDouble.rounded(to: 7), 3.1415927)
    XCTAssertEqual(piFloat80.rounded(to: 7), 3.1415927)

    piFloat80.round(to: 16, rule: .down)
    XCTAssertEqual(piFloat80, 3.141_592_653_589_793_2)
    piFloat80.round(to: 15, rule: .up)
    XCTAssertEqual(piFloat80, 3.141_592_653_589_794)
    piFloat.round(to: 3)
    XCTAssertEqual(piFloat, 3.142)
    piDouble.round(to: 2)
    XCTAssertEqual(piDouble, 3.14)
    piFloat80.round(to: 1)
    XCTAssertEqual(piFloat80, 3.1)

    XCTAssertEqual(negativeDouble.rounded(to: 2), -147.96)
    negativeDouble.round(to: 3)
    XCTAssertEqual(negativeDouble, -147.956)

    XCTAssertEqual(randomFloat.rounded(to: 0), 200)

    randomFloat.round(to: 5)
    XCTAssertEqual(randomFloat, 199.95902)
    randomFloat.round(to: 3)
    XCTAssertEqual(randomFloat, 199.959)
    XCTAssertEqual(randomFloat.rounded(to: 10), 199.959)
    XCTAssertEqual(randomFloat.rounded(to: -5), 199.959)
    randomFloat.round(to: -66)
    XCTAssertEqual(randomFloat, 199.959)
    XCTAssertEqual(randomFloat.rounded(to: 0), 200)
    randomFloat.round(to: 2)
    XCTAssertEqual(randomFloat, 199.96)

    XCTAssertEqual(bigFloat.rounded(to: 99), bigFloat)
    XCTAssertEqual(bigFloat.rounded(to: -99), bigFloat)
    XCTAssertEqual(bigFloat.rounded(to: 0), 1)
    XCTAssertEqual(bigFloat.rounded(to: 10), 0.9278766112)

    bigFloat.round(to: 16, rule: .up)
    XCTAssertEqual(bigFloat, 0.9278766111959093)
    bigFloat.round(to: -1)
    XCTAssertEqual(bigFloat, 0.9278766111959093)
    bigFloat.round(to: 3)
    XCTAssertEqual(bigFloat, 0.928)

  }

  func testCeiling() {
    var piFloat         = Float(3.141_592_653_589_793_238_46)   //  3.14159274
    var piDouble        = 3.14159_26535_89793_23846             //  3.1415926535897931
    var piFloat80       = Float80(3.14159_26535_89793_23846)    //  3.141592653589793116

    var negativeDouble  = -147.956455                           //  -147.95645500000001
    var randomFloat     = Float32(199.959019)                    //  199.959015
    var bigFloat        = Float80(0.9278766111959092165201989)  //  0.927876611195909251073

    XCTAssertEqual(piFloat.ceiled(to: 0), 4.0)
    XCTAssertEqual(piFloat.ceiled(to: -1), 3.14159274)
    XCTAssertTrue((piFloat.ceiled(to: 1000)).isNaN)

    XCTAssertEqual(piFloat.ceiled(to: 5), 3.1416)
    XCTAssertEqual(piDouble.ceiled(to: 5), 3.1416)
    XCTAssertEqual(piFloat80.ceiled(to: 5), 3.1416)

    piFloat.ceil(to: 3)
    XCTAssertEqual(piFloat, 3.142)
    piDouble.ceil(to: 2)
    XCTAssertEqual(piDouble, 3.15)
    piFloat80.ceil(to: 1)
    XCTAssertEqual(piFloat80, 3.2)

    XCTAssertEqual(negativeDouble.ceiled(to: 2), -147.95)
    negativeDouble.ceil(to: 3)
    XCTAssertEqual(negativeDouble, -147.956)

    XCTAssertEqual(randomFloat.ceiled(to: 0), 200)
    randomFloat.ceil(to: 4)
    XCTAssertEqual(randomFloat, 199.9591)
    randomFloat.ceil(to: 3)
    XCTAssertEqual(randomFloat, 199.96)
    XCTAssertEqual(randomFloat.ceiled(to: 10), 199.96)
    XCTAssertEqual(randomFloat.ceiled(to: -5), 199.96)
    randomFloat.ceil(to: -66)
    XCTAssertEqual(randomFloat, 199.96)
    XCTAssertEqual(randomFloat.ceiled(to: 0), 200)
    randomFloat.ceil(to: 2)
    XCTAssertEqual(randomFloat, 199.96)
    randomFloat.ceil(to: 1)
    XCTAssertEqual(randomFloat, 200)

    XCTAssertEqual(bigFloat.ceiled(to: 99), bigFloat)
    XCTAssertEqual(bigFloat.ceiled(to: -99), bigFloat)
    XCTAssertEqual(bigFloat.ceiled(to: 0), 1)
    XCTAssertEqual(bigFloat.ceiled(to: 10), 0.9278766112)
    bigFloat.ceil(to: 16)
    XCTAssertEqual(bigFloat, 0.9278766111959093)
    bigFloat.ceil(to: -1)
    XCTAssertEqual(bigFloat, 0.9278766111959093)
    bigFloat.ceil(to: 3)
    XCTAssertEqual(bigFloat, 0.928)

  }

  func testFlooring() {
    var piFloat         = Float(3.141_592_653_589_793_238_46)   //  3.14159274
    var piDouble        = 3.14159_26535_89793_23846             //  3.1415926535897931
    var piFloat80       = Float80(3.14159_26535_89793_23846)    //  3.141592653589793116

    var randomFloat     = Float32(199.959019)                    //  199.959015
    var bigFloat        = Float80(0.9278766111959092165201989)  //  0.927876611195909251073

    XCTAssertEqual(piFloat.floored(to: 0), 3.0)
    XCTAssertEqual(piFloat.floored(to: -1), 3.14159274)
    XCTAssertTrue((piFloat.floored(to: 1000)).isNaN)

    XCTAssertEqual(piFloat.floored(to: 5), 3.14159)
    XCTAssertEqual(piDouble.floored(to: 5), 3.14159)
    XCTAssertEqual(piFloat80.floored(to: 5), 3.14159)

    piFloat.floor(to: 3)
    XCTAssertEqual(piFloat, 3.141)
    piDouble.floor(to: 2)
    XCTAssertEqual(piDouble, 3.14)
    piFloat80.floor(to: 1)
    XCTAssertEqual(piFloat80, 3.1)

    XCTAssertEqual(randomFloat.floored(to: 0), 199)
    randomFloat.floor(to: 4)
    XCTAssertEqual(randomFloat, 199.959)
    randomFloat.floor(to: 3)
    XCTAssertEqual(randomFloat, 199.959)
    XCTAssertEqual(randomFloat.floored(to: 10), 199.959)
    XCTAssertEqual(randomFloat.floored(to: -5), 199.959)
    randomFloat.floor(to: -66)
    XCTAssertEqual(randomFloat, 199.959)
    XCTAssertEqual(randomFloat.floored(to: 0), 199)
    randomFloat.floor(to: 2)
    XCTAssertEqual(randomFloat, 199.95)
    randomFloat.floor(to: 1)
    XCTAssertEqual(randomFloat, 199.9)

    XCTAssertEqual(bigFloat.floored(to: 99), bigFloat)
    XCTAssertEqual(bigFloat.floored(to: -99), bigFloat)
    XCTAssertEqual(bigFloat.floored(to: 0), 0)
    XCTAssertEqual(bigFloat.floored(to: 10), 0.9278766111)
    bigFloat.floor(to: 16)
    XCTAssertEqual(bigFloat, 0.9278766111959092)
    bigFloat.floor(to: -1)
    XCTAssertEqual(bigFloat, 0.9278766111959092)
    bigFloat.floor(to: 16)
    XCTAssertEqual(bigFloat, 0.9278766111959092)
    bigFloat.floor(to: 3)
    XCTAssertEqual(bigFloat, 0.927)

  }

}
