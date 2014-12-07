//
//  NorwegianSSN.swift
//  NorwegianSSN
//
//  Created by Christoffer Winterkvist on 06/12/14.
//
//

import Foundation

let TwentiethCenturyRange = NSMakeRange(0, 500)
let NineteenthCenturyRange = NSMakeRange(500, 749-500+1)
let TwentyFirstCenturyRange = NSMakeRange(500, 999-500+1)
let TwentiethCenturyAlternateRange = NSMakeRange(900, 999-900+1)

@objc class NorwegianSSN : NSObject {

    private let firstWeightNumbers: [UInt]  = [3,7,6,1,8,9,4,5,2]
    private let secondWeightNumbers: [UInt] = [5,4,3,2,7,6,5,4,3,2]
    var SSN: String

    init(ssn: String) {
        SSN = ssn
    }

    func validateWithString(string: String) -> Bool {
        return NorwegianSSN(ssn: string).isValid()
    }

    func age() -> Int {
        if countElements(SSN) == 11 {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "DDMMyyyy"

            if let dateOfBirthStringWithCenturyString = dateOfBirthStringWithCentury() {
                if let birthday = formatter.dateFromString(dateOfBirthStringWithCenturyString) {
                    let now = NSDate()
                    let ageComponents = NSCalendar.currentCalendar()
                        .components(NSCalendarUnit.CalendarUnitYear, fromDate: birthday, toDate: now, options: nil)
                    return ageComponents.year
                }
            }
        }
        return 0
    }

    func isDNumber() -> Bool {
        return DNumberValue() > 3
    }

    func isFemale() -> Bool {
        return (personalNumber() % 2) != 0
    }

    func isMale() -> Bool {
        return !isFemale()
    }

    func isValid() -> Bool {
        if SSN.isEmpty || countElements(SSN) != 11 {
            return false
        }

        let ssn = (SSN as NSString).substringToIndex(9)
        var firstControlDigit:  Int = modulusEleven(calculateSSN(ssn, weightNumbers: firstWeightNumbers))
        var secondControlDigit: Int = calculateSSN(ssn, weightNumbers: secondWeightNumbers)
        secondControlDigit += Int(secondWeightNumbers.last!) * firstControlDigit
        secondControlDigit = modulusEleven(secondControlDigit)

        return firstControlDigit == self.firstControlNumber() &&
            secondControlDigit == self.secondControlNumber()
    }

    func dateOfBirthString() -> String? {
        if let extractDateOfBirthString = extractDateOfBirth() {
            var birthdayString = NSMutableString(string: extractDateOfBirthString)

            if (isDNumber()) {
                var firstDigit = DNumberValue() - 4
                birthdayString.replaceCharactersInRange(NSMakeRange(0, 1), withString: String(firstDigit))
            }

            return birthdayString
        } else {
            return nil
        }
    }

    func dateOfBirthStringWithCentury() -> NSString? {
        var birthdayString = NSMutableString(string: dateOfBirthString()!)
        birthdayString.insertString(bornInCentury(personalNumber()), atIndex: 4)
        return birthdayString
    }

    func birthdate() -> String {
        return ""
    }

    func calculateSSN(ssn :String, weightNumbers :[UInt]) -> Int {
        var result = 0;
        var index: Int;
        for index = 0; index < countElements(ssn); ++index {
            var string = (ssn as NSString).substringWithRange(NSMakeRange(index, 1))
            result += Int(weightNumbers[index]) * String(string).toInt()!
        }

        return result
    }

    func personalNumber() -> Int {
        return personalNumberString().toInt()!
    }

    func DNumberValue() -> Int {
        return (countElements(SSN) >= 1) ?
            (SSN as NSString).substringToIndex(1).toInt()!
            : 0
    }

    func extractDateOfBirth() -> String? {
        if countElements(SSN) == 11 {
            return (SSN as NSString).substringToIndex(6)
        } else {
            return nil
        }
    }

    func personalNumberString() -> String {
        return (SSN as NSString).substringWithRange(NSMakeRange(6, 3))
    }

    func controlNumberString() -> String {
        return (SSN as NSString).substringFromIndex(9)
    }

    func firstControlNumber() -> Int {
        return (controlNumberString() as NSString).substringToIndex(1).toInt()!
    }

    func secondControlNumber() -> Int {
        return (controlNumberString() as NSString).substringFromIndex(1).toInt()!
    }

    func modulusEleven(var controlDigit :Int) -> Int {
        controlDigit = 11 - (controlDigit % 11)
        return (controlDigit == 11) ? 0 : controlDigit
    }

    func bornInCentury(personalNumber :Int) -> String {

        if NSLocationInRange(personalNumber, TwentiethCenturyRange) {
            return "19"
        } else if NSLocationInRange(personalNumber, NineteenthCenturyRange) {
            return "18"
        } else if NSLocationInRange(personalNumber, TwentyFirstCenturyRange) {
            return "20"
        } else if NSLocationInRange(personalNumber, TwentiethCenturyAlternateRange) {
            return "19"
        }

        return "20"
    }
}
