//
//  NumerationTranfer.swift
//  CyberTools
//
//  Created by John on 2021/3/12.
//

import Foundation
import UIKit

public enum numeration: Comparable {
    case binary // 2
    case decimal // 10
    case sexadecimal //16
    
    static var all: [numeration] = {
        return [
            numeration.binary,
            numeration.decimal,
            numeration.sexadecimal
        ]
    }()
    
    func description() -> String {
        switch self {
        case .binary:
            return JNWLocalizedString(key: "binary")
        case .decimal:
            return JNWLocalizedString(key: "decimal")
        case .sexadecimal:
            return JNWLocalizedString(key: "sexadecimal")
        }
    }
}

class NumerationTranfer {
    
    public static func transfer(value: String, from: numeration, to: numeration) -> String {
        
        let decimalNumStr = transformToDecimal(value: value, from: from)
        let targetNumStr = transformFromDecimal(value: decimalNumStr, to: to)
        
        return targetNumStr
    }
}

private extension NumerationTranfer {
    
    static func transformToDecimal(value: String, from: numeration) -> String {
        
        if isGreaterThanMaxInt(value: value) {
            return ""
        }
        
        guard isValidNumberString(value: value) else { return "" }
        
        var res = 0
        let step = getNumerationNumber(numer: from)
        var level = 0
        
        for char in value.reversed() {
            guard let num = Int(getNumberValueFromNumerationStr(value: String(char), from: from)) else { continue }
            res += num * Int(pow(CGFloat(step), CGFloat(level)))
            level += 1
        }
        
        return "\(res)"
    }

    static func transformFromDecimal(value: String, to: numeration) -> String {
        
        guard isValidNumberString(value: value) else { return "" }
        
        var valueNum = Int(value) ?? 0
        var res = ""
        let step = getNumerationNumber(numer: to)
        
        while valueNum > 0 {
            let currentRes = valueNum%step
            res = "\(getStringDescFromDecimalNumeration(value: currentRes, from: to))\(res)"
            valueNum = valueNum/step
        }
        
        return res
    }

    static func isNumber(char: Character) -> Bool {
        return ("0"..."9").contains(String(char))
    }

    static func isValidNuerationNum(char: Character) -> Bool {
        return ("A"..."F").contains(String(char)) || isNumber(char: char)
    }

    static func isValidNumberString(value: String) -> Bool {
        for char in value {
            if !isValidNuerationNum(char: char) {
                return false
            }
        }
        return true
    }
    
    static func isGreaterThanMaxInt(value: String) -> Bool {
        if "\(Int.max)".count > value.count {
            return false
        } else if "\(Int.max)".count < value.count {
            return true
        } else if "\(Int.max)".count == value.count {
            for charIndex in 0...value.count {
                let index = value.index(value.startIndex, offsetBy: charIndex)
                if value[index] > "\(Int.max)"[index] {
                    return true
                }
            }
            return false
        } else {
            return false
        }
    }

    static func getNumerationNumber(numer: numeration) -> Int {
        switch numer {
        case .binary:
            return 2
        case .decimal:
            return 10
        case .sexadecimal:
            return 16
        }
    }

    static func getStringDescFromDecimalNumeration(value: Int, from: numeration) -> String {
        
        switch from {
        case .binary:
            return "\(value)"
        case .decimal:
            return "\(value)"
        case .sexadecimal:
            if value < 10 {
                return "\(value)"
            } else {
                switch value {
                case 10:
                    return "A"
                case 11:
                    return "B"
                case 12:
                    return "C"
                case 13:
                    return "D"
                case 14:
                    return "E"
                case 15:
                    return "F"
                default:
                    return "\(value)"
                }
            }
        }
    }

    static func getNumberValueFromNumerationStr(value: String, from: numeration) -> String {
        
        switch from {
        case .binary:
            return "\(value)"
        case .decimal:
            return "\(value)"
        case .sexadecimal:
            switch value {
            case "A":
                return "\(10)"
            case "B":
                return "\(11)"
            case "C":
                return "\(12)"
            case "D":
                return "\(13)"
            case "E":
                return "\(14)"
            case "F":
                return "\(15)"
            default:
                return "\(value)"
            }
        }
    }

}
