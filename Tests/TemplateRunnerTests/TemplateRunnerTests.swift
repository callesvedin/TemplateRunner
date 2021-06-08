import XCTest
import class Foundation.Bundle
import TemplateRunnerCore

final class TemplateRunnerTests: XCTestCase {

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    func testNrOfItemsInFile() throws {
        let parser = CSVInputParser(
            """
                TEST 1, TEST 2
                Value 11, Value 12
                Value 21, Value 22
            """)
        let result = try parser.parse()
        let items = result["items"] as! Array<[String:String]>
        XCTAssertEqual(items.count,2 , "Number of items are wrong")
    }

    func testWrongNumberOfValues() throws {
        let parser = CSVInputParser(
            """
                TEST 1, TEST 2
                Value 11, Value 12, Value 13
                Value 21, Value 22
            """)
        do {
            _ = try parser.parse()
            XCTFail("Code should throw error")
        }catch ParserError.parseFailed(let reason){
            print("Parser error thrown. Reason \(reason)")
        }catch{
            print("Parser threw wrong error:\(error.localizedDescription)")
            XCTFail("Code threw wrong error. Error:\(error)")
        }
    }
    
    func testComments() throws {
        let parser = CSVInputParser(
            """
                TEST 1, TEST 2
                Value 11, Value 12
                # This is a comment
                Value 21, Value 22
            """)
        do {
            _ = try parser.parse()
        }catch ParserError.parseFailed(let reason){
            print("Parser error thrown. Reason \(reason)")
            XCTFail("Code threw wrong error. Error:\(reason)")
        }catch{
            print("Parser threw wrong error:\(error.localizedDescription)")
            XCTFail("Code threw wrong error. Error:\(error)")
        }
    }

    func testEmptyLine() throws {
        let parser = CSVInputParser(
            """
                TEST 1, TEST 2
                Value 11, Value 12
                
                Value 21, Value 22
            """)
        do {
            _ = try parser.parse()
        }catch ParserError.parseFailed(let reason){
            print("Parser error thrown. Reason \(reason)")
            XCTFail("Code threw wrong error. Error:\(reason)")
        }catch{
            print("Parser threw wrong error:\(error.localizedDescription)")
            XCTFail("Code threw wrong error. Error:\(error)")
        }
    }


    static var allTests = [
        ("testNrOfItemsInFile", testNrOfItemsInFile),
        ("testWrongNumberOfValues", testWrongNumberOfValues),
        ("testComments", testComments),
        ("testEmptyLine", testEmptyLine)
    ]
}
