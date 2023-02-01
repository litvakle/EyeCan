//
//  PDFReaderViewModelTests.swift
//  EyeCanTests
//
//  Created by Lev Litvak on 01.02.2023.
//

import XCTest
@testable import EyeCan

class PDFReaderViewModelTests: XCTestCase {
    func test_readFile_requestsReaderOnSuccessfulResult() {
        let (sut, reader) = makeSUT()
        
        sut.readFile(from: .success(anyURL()))
        sut.readFile(from: .success(anyURL()))
        
        XCTAssertEqual(reader.readFileCallCount, 2)
    }

    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (PDFReaderViewModel, PDFReaderSpy) {
        let reader = PDFReaderSpy()
        let sut = PDFReaderViewModel(reader: reader)
        
        trackForMemoryLeaks(reader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, reader)
    }
    
    private class PDFReaderSpy: PDFReader {
        var readFileCallCount = 0

        func readFile(from url: URL) -> Result<String, EyeCan.PDFReaderError> {
            readFileCallCount += 1
            return .success("")
        }
    }
}