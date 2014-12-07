import Cocoa
import XCTest

class NorwegianSSNTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSSNValidation() {
        let ssn = NorwegianSSN.init(ssn:"01015000232")
        XCTAssertTrue(ssn.isValid())
    }

    func testAgePresence() {
        let ssn = NorwegianSSN.init(ssn:"01015000232")

        XCTAssertGreaterThan(ssn.age(), 0);
    }

    func testAgeCalculation() {
        let ssn = NorwegianSSN.init(ssn:"01015000232")

        XCTAssertEqual(ssn.age(), 64)
    }

    func testIfFemale() {
        let ssn = NorwegianSSN.init(ssn:"01015000232")

        XCTAssertFalse(ssn.isFemale())
    }

    func testIfMale() {
        let ssn = NorwegianSSN.init(ssn:"01015000232")

        XCTAssertTrue(ssn.isMale());
    }

    func testDNumber() {
        let ssn = NorwegianSSN.init(ssn:"01015000232")

        XCTAssertFalse(ssn.isDNumber());
    }

    func testDateOfBirthString() {
        let ssn = NorwegianSSN.init(ssn:"01015000232")

        XCTAssertEqual(ssn.dateOfBirthString()!, "010150");
    }

    func testDateOfBirthStringWithCentury() {
        let ssn = NorwegianSSN.init(ssn:"01015000232")
        XCTAssertEqual(ssn.dateOfBirthStringWithCentury()!, "01011950");
    }

    func testBirthdate() {
        let ssn = NorwegianSSN.init(ssn:"01015000232")
        let formatter = NSDateFormatter()
        formatter.dateFormat = "DDMMyyyy"
        let date = formatter.dateFromString(ssn.dateOfBirthStringWithCentury()!)

        XCTAssertNotNil(date)
    }

    func testAgeDateConversion() {
        let ssn = NorwegianSSN.init(ssn:"14028849959")

        XCTAssertEqual(ssn.age(), 26)
    }

    func testStringRangeSafety() {
        let ssn = NorwegianSSN.init(ssn:"11")

        XCTAssertNil(ssn.dateOfBirthString())
        
    }
}
