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
    
    func test_readFile_doesNotRequestReaderOnFailure() {
        let (sut, reader) = makeSUT()
        
        sut.readFile(from: .failure(anyNSError()))
        
        XCTAssertEqual(reader.readFileCallCount, 0)
    }
    
    func test_readFile_deliversErrorOnFailure() {
        let (sut, _) = makeSUT()
        
        sut.readFile(from: .failure(anyNSError()))
        
        XCTAssertEqual(sut.error, .chooseDialog(error: anyNSError().localizedDescription))
    }
    
    func test_readFile_deliversErrorOnReaderError() {
        let (sut, reader) = makeSUT()
        
        PDFReaderError.allCases.forEach { error in
            reader.error = error
            sut.readFile(from: .success(anyURL()))
            
            XCTAssertEqual(sut.error, .reader(error: error.localizedDescription))
        }
    }
    
    func test_readFile_deliversDataOnSuccess() {
        let (sut, reader) = makeSUT()
        reader.data = anyData()
        
        sut.readFile(from: .success(anyURL()))
        
        XCTAssertEqual(sut.data, anyData())
    }
    
    func test_readFile_doesNotDeliverErrorOnSuccessAfterPreviousError() {
        let (sut, reader) = makeSUT()
        reader.error = .fileAccessError
        
        sut.readFile(from: .success(anyURL()))
        reader.error = nil
        sut.readFile(from: .success(anyURL()))
        
        XCTAssertNil(sut.error)
    }
    
    func test_readFile_leadsToSetShowErrorToTrueOnErrorAndToFalseOnSuccessAfterPreviousError() {
        let (sut, reader) = makeSUT()
        reader.error = .fileAccessError
        
        sut.readFile(from: .success(anyURL()))
        XCTAssertTrue(sut.showError)
        
        reader.error = nil
        sut.readFile(from: .success(anyURL()))
        XCTAssertFalse(sut.showError)
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
        var error: PDFReaderError?
        var data = anyData()
        
        func readFile(from url: URL) -> Result<Data, EyeCan.PDFReaderError> {
            readFileCallCount += 1
            
            if let error = error {
                return .failure(error)
            }
            
            return .success(data)
        }
    }
}
