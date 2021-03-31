import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TemplateRunnerTests.allTests),
        testCase(CSVInputParser_tests.allTests),
    ]
}
#endif
