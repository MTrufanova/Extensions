import XCTest
import Combine
@testable import SwiftExtension

final class SwiftExtensionTests: XCTestCase {
	func testAdd() throws {
		XCTAssert("20.0" == .empty.addToTail(20.0))
	}
	
	func testNonOptional() throws {
		var nilString: String? = nil
		XCTAssert(nilString.nonOptional() == "")
		XCTAssert(nilString.nonOptional("Hello, world!") == "Hello, world!")
		
		nilString = "Hello!"
		
		XCTAssert(nilString.nonOptional() == "Hello!")
		XCTAssert(nilString.nonOptional("Hello, world!") == "Hello!")
		
		var nilFloat: Float? = nil
		XCTAssert(nilFloat.nonOptional() == 0.0)
		XCTAssert(nilFloat.nonOptional(20.0) == 20.0)
		
		nilFloat = 30.0
		XCTAssert(nilFloat.nonOptional() == 30.0)
		XCTAssert(nilFloat.nonOptional(20.0) == 30.0)
		
		var nilValue: (String, Double)? = nil
		XCTAssert(nilValue.nonOptional(("20.0", 30.0)) == ("20.0", 30.0))
		nilValue = ("20.0", 30.0)
		XCTAssert(nilValue.nonOptional(("30.0", 30.0)) == ("20.0", 30.0))
	}
	
	func testSafeInArray() throws {
		let array: [String] = ["Privet", "Hello"]
		XCTAssert(array[safe: 0] == "Privet")
		XCTAssert(array[safe: 3] == nil)
		
		let emptyArray: [String] = []
		XCTAssert(emptyArray[safe: 20] == nil)
	}
	
	func testRemoveFirstSpaceSymbol() throws {
		let exampleText = "    Hello!    "
		let successResult = "Hello!    "
		
		let spaceText = "         "
		let resultSpaceText = ""
		XCTAssert(exampleText.textWithoutSpacePrefix() == successResult)
		XCTAssert(successResult.textWithoutSpacePrefix() == successResult)
		XCTAssert(spaceText.textWithoutSpacePrefix() == resultSpaceText)
		XCTAssert(resultSpaceText.textWithoutSpacePrefix() == resultSpaceText)
	}
	
	func testCapitalizingFirstLetter() throws {
		let exampleText = "abbbbb bbbbb"
		let exampleResultText = "Abbbbb bbbbb"
		
		let emptyText = ""
		let emptyResultText = ""
		
		XCTAssert(exampleText.capitalizingFirstLetter() == exampleResultText)
		XCTAssert(emptyText.capitalizingFirstLetter() == emptyResultText)
	}
	
	func testFunctionalPlusString() throws {
		let exampleText = "bla"
		let exampleResultText = "bla bla"
		let transformText = exampleText.addToTail(.space).addToTail(exampleText)
		
		XCTAssert(transformText == exampleResultText)
	}
	
	func testSum() throws {
		let intValue: Int = 20
		let doubleValue: Double = 30.0
		let floatValue: Float = 50.0
		let cgfloatValue: CGFloat = 35.0
		
		XCTAssert(floatValue.sum(doubleValue) == 80.0)
		XCTAssert(floatValue.sum(intValue) == 70.0)
		
		XCTAssert(doubleValue.sum(intValue).sum(floatValue) == 100.0)
		XCTAssert(cgfloatValue.sum(floatValue) == 85.0)
		
		XCTAssert(intValue.sumTo(cgfloatValue) == 55.0)
	}
	
	func testSubtraction() throws {
		let intValue: Int = 20
		let doubleValue: Double = 30.5
		let floatValue: Float = 24.5
		let cgfloatValue: CGFloat = 5.7
		
		XCTAssert(cgfloatValue.subtraction(intValue) == -14.3)
		XCTAssert(doubleValue.subtraction(intValue).subtraction(cgfloatValue) == 4.8)
		XCTAssert(intValue.subtraction(doubleValue) == -10)
		XCTAssert(intValue.subtraction(cgfloatValue).subtraction(doubleValue) == -15)
		XCTAssert(floatValue.subtraction(intValue) == 4.5)
		
		XCTAssert(intValue.subtractionTo(cgfloatValue) == 14.3)
	}
	
	func testDivision() throws {
		let intValue: Int = 2
		let doubleValue: Double = 30.0
		let floatValue: Float = 24.5
		let cgfloatValue: CGFloat = 5.0
		
		XCTAssert(cgfloatValue.division(intValue) == 2.5)
		XCTAssert(doubleValue.division(intValue).division(cgfloatValue) == 3.0)
		XCTAssert(intValue.division(doubleValue) == 0)
		XCTAssert(intValue.division(cgfloatValue).division(doubleValue) == 0)
		XCTAssert(floatValue.division(intValue) == 12.25)
		
		XCTAssert(intValue.divisionTo(cgfloatValue) == 0.4)
	}
	
	func testTextWithoutPostfix() throws {
		var testValue: String = "lalala\"lala\""
		var successResult: String = "lalala\"lala"
		
		XCTAssert(testValue.textWithoutCharacterPostfix(character: "\"") == successResult)
		
		testValue = ""
		successResult = ""
		
		XCTAssert(testValue.textWithoutCharacterPostfix(character: "\"") == successResult)
		
		testValue = "lalalalala)))))))))"
		successResult = "lalalalala"
		
		XCTAssert(testValue.textWithoutCharacterPostfix(character: ")") == successResult)
		
		testValue = ")))))))))))"
		successResult = ""
		
		XCTAssert(testValue.textWithoutCharacterPostfix(character: ")") == successResult)
	}
	
	func testMultiplication() throws {
		let intValue: Int = 2
		let doubleValue: Double = 30.5
		let floatValue: Float = 24.5
		let cgfloatValue: CGFloat = 5.7
		
		XCTAssert(cgfloatValue.multiplication(intValue) == 11.4)
		XCTAssert(doubleValue.multiplication(intValue).multiplication(cgfloatValue) == 347.7)
		XCTAssert(intValue.multiplication(doubleValue) == 60)
		XCTAssert(intValue.multiplication(cgfloatValue).multiplication(doubleValue) == 300)
		XCTAssert(floatValue.multiplication(intValue) == 49.0)
		
		XCTAssert(intValue.multiplicationTo(2.7) == 5.4)
	}
	
	func testAnyOptionalValue() throws {
		var value: String? = "Good bye!"
		var result = value
			.orOptional("Hello!")
			.nonOptional("Privet!")
		XCTAssert(result == value)
		
		value = nil
		
		result = value
			.orOptional("Hello!")
			.nonOptional("Privet!")
		XCTAssert(result == "Hello!")
		
		result = value
			.orOptional(nil)
			.nonOptional("Privet!")
		XCTAssert(result == "Privet!")
	}
	
	func testAppendToArrayInDictionary() throws {
		var dictionary: [String: [Int]] = ["value": [0, 1, 2]]
		
		XCTAssert(dictionary["v"] == nil)
		
		dictionary.appendWithCreateIfNeed(key: "v", 2)
		
		XCTAssert(dictionary["v"] == [2])
		
		dictionary.appendWithCreateIfNeed(key: "v", 3)
		
		XCTAssert(dictionary["v"] == [2, 3])
	}
	
	func testBoolean() {
		let one: Bool = true || false
		let two: Bool = true && true
		let three: Bool = true || true
		let four: Bool = false && false
		
		XCTAssert(one == true.or(false))
		XCTAssert(two == true.and(true))
		XCTAssert(three != true.xor(true))
		XCTAssert(four == false.and(false))
	}
	
	func testTernary() throws {
		XCTAssert(
			Ternary.get(
				if: .value(20 < 30),
				  true: .value(true),
				  false: .func({
					  false
				  })
			)
		)
	}
	
	func testTransform() {
		XCTAssert(20 == 20.0.toBinaryInteger())
		XCTAssert(20.0 == 20.toBinaryFloatingPoint())
	}
	
	func testNegative() {
		XCTAssert(-20 == 20.negative())
		XCTAssert(-30.0 == 30.0.negative())
	}
	
	func testMoreDictionary() {
		let keyPrivet = "Privet"
		let keyPoka = "Poka"
		let values: [String: [Int: Double]]
		values = [:]
			.setValueNon(key: keyPrivet) {
				$0.setValue(key: 300, 29.0)
			}
			.setValueNon(key: keyPoka) {
				$0.setValue(key: 200, 30.0).setValue(key: 400, 75.0)
			}.setValueNon(key: keyPrivet) {
				$0.setValue(key: 402, 89.0)
			}.setValueNon(key: keyPrivet) {$0}
		
		XCTAssert(values == [keyPrivet: [300: 29.0, 402: 89.0], keyPoka: [200: 30.0, 400: 75.0]])
		print(values)
	}
}
