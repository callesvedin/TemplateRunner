//
//  SwiftReplacer.swift
//  templaterunner
//
//  Created by carl-johan.svedin on 2021-02-27.
//

import Foundation
//
//  main.swift
//  TemplateReplacer
//
//  Created by carl-johan.svedin on 2021-02-25.
//

import Foundation
import ArgumentParser
import Stencil


struct TemplateRunner: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "A Swift command-line tool to generate output")
    
    @Option(name: .shortAndLong, help: "The file path to the Stencil template")
    private var template: String
    
    @Option(name: .shortAndLong, help: "Path to input data file")
    private var input: String

    @Option(name: .shortAndLong, help: "Path to output file")
    private var output: String
    
    @Flag(name: .shortAndLong, help: "Use verbose output")
    private var verbose: Bool = false
    
    func run() throws {
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
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        
    }
    
    func writeOutput(result:String, to filePath:String) {
//        let path = FileManager.default.urls(for: .documentDirectory,
//                                            in: .userDomainMask)[0].appendingPathComponent("myFile")
//
        if let stringData = result.data(using: .utf8) {
            try? stringData.write(to: URL(fileURLWithPath: filePath))
        }
    }
}
