//
//  PDFReaderViewModel.swift
//  EyeCan
//
//  Created by Lev Litvak on 01.02.2023.
//

import Combine
import PDFKit

class PDFReaderViewModel: ObservableObject {
    @Published private(set) var text = ""
    @Published private(set) var error: ViewModelError?
    @Published var showError = false
    
    let reader: PDFReader
    
    init(reader: PDFReader) {
        self.reader = reader
        
        $error
            .map { $0 != nil }
            .assign(to: &$showError)
    }
    
    enum ViewModelError: Equatable {
        case chooseDialog(error: String)
        case reader(error: String)
        
        var message: String {
            switch self {
            case let .chooseDialog(error):
                return "Choose file error: \(error)"
            case let .reader(error):
                return "Error reading PDF-file: \(error)"
            }
        }
    }
    
    func readFile(from result: Result<URL, Error>) {
        error = nil
        switch result {
        case let .success(url):
            let readResult = reader.readFile(from: url)
            handleReadResult(readResult)
        case let .failure(error):
            self.error = .chooseDialog(error: error.localizedDescription)
        }
    }
    
    private func handleReadResult(_ result: Result<String, PDFReaderError>) {
        switch result {
        case let .success(text):
            self.text = text
        case let .failure(error):
            self.error = .reader(error: error.localizedDescription)
        }
    }
}
