//
//  File.swift
//  
//
//  Created by carl-johan.svedin on 2021-06-07.
//

import Foundation
import Stencil

public struct TemplateRunnerCommand {
    private var template: String
    private var input: String
    private var output: String
    private var verbose: Bool = false
    
    public init(template: String, input: String, output: String, verbose: Bool = false) {
        self.template = template
        self.input = input
        self.output = output
        self.verbose = verbose
    }
    
    public func run() throws {
        if verbose {
            print("Creating output from template at '\(template)' and data at '\(input)'")
        }
        do {
            let templateContents = try String(contentsOfFile: template, encoding: .utf8)
            let inputParser = try ParserFactory.getParser(filePath: input)
            let inputData = try inputParser.parse()
            
            let environment = Environment()
            
            let context = inputData
            let result = try environment.renderTemplate(string: templateContents, context: context)
            
            if (verbose) {
                print("\(result)")
            }
            
            writeOutput(result:result, to:output)
            print("Wrote result to \(output)")
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        
    }
    
    func writeOutput(result:String, to filePath:String) {
        if let stringData = result.data(using: .utf8) {
            try? stringData.write(to: URL(fileURLWithPath: filePath))
        }
    }
}
