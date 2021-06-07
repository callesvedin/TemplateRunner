//
//  InputParser.swift
//  TemplateReplacer
//
//  Created by carl-johan.svedin on 2021-02-26.
//

import Foundation

public enum ParserError:Error {
    case unknownInputFormat(message:String)
    case parseFailed(reason:String)
}

public protocol InputParser {
    init(_ someParameter: String)
    func parse() throws -> [String:Any]
}


open class ParserFactory {
    public static func getParser(filePath:String) throws -> InputParser {
        let ext = filePath.split(separator: ".").last
        let dataContents = try String(contentsOfFile: filePath, encoding: .utf8)
        switch ext {
        case "csv":
            return CSVInputParser(dataContents)
        default:
            throw ParserError.unknownInputFormat(message: "The input kind '\(ext ?? "")' is not known.")
        }
        
    }
}
