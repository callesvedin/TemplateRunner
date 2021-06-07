import Foundation
import ArgumentParser
import Stencil
import TemplateRunnerCore


struct TemplateRunner: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "A Swift command-line tool to generate output with Stencil using a csv file as input")
    
    @Option(name: .shortAndLong, help: "The file path to the Stencil template")
    private var template: String
    
    @Option(name: .shortAndLong, help: "Path to input data file (.csv)")
    private var input: String

    @Option(name: .shortAndLong, help: "Path to output file")
    private var output: String
    
    @Flag(name: .shortAndLong, help: "Use verbose output")
    private var verbose: Bool = false
    
    func run() throws {
        do {            
            let command = TemplateRunnerCommand(template: template, input:input, output:output, verbose:verbose)
            try command.run()
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
