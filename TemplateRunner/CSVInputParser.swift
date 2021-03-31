//
//  CSVInputParser.swift
//  TemplateReplacer
//
//  Created by carl-johan.svedin on 2021-02-26.
//

import Foundation


class CSVInputParser: InputParser {
    private let input:String
    
    required init(_ input:String) {
        self.input = input
    }
    
    func parse() throws -> [String : Any] {
        var keys:[String]
        var items = [[String:String]]()
        
        let lines = input.split(separator: "\n")
        keys = lines[0].split(separator: ",").map({$0.trimmingCharacters(in: CharacterSet.whitespaces)})

        for i in 1..<lines.count {
            var item = [String:String]()
            let line = lines[i].split(separator: ",").map({$0.trimmingCharacters(in: CharacterSet.whitespaces)})
            guard line.count == keys.count else {
                throw ParserError.parseFailed(reason: "Line \(i) had wrong number of values. Was \(line.count) but should have been \(keys.count)")
            }
            for index in 0..<keys.count {
                let key = keys[index]
                let value = line[index]
                item[String(key)] = String(value)
            }
            items.append(item)
        }
        return ["items":items]
//        return
//            ["items":
//                [
//                    ["newsitemTitle":"Article B","newsitemType":"b","newsitemPriority":"1","newspilotTitle":"A 3100 (8)","newspilotTypeId":"117"],
//                    ["newsitemTitle":"Article A","newsitemType":"a","newsitemPriority":"2","newspilotTitle":"B 3100 (8)","newspilotTypeId":"225"]
//                ]
//        ]
    }
    
    
}
