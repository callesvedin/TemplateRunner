//
//  templaterunner_tests.swift
//  templaterunner_tests
//
//  Created by carl-johan.svedin on 2021-02-27.
//

import XCTest

import templaterunner

class CSVInputParser_tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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


}
