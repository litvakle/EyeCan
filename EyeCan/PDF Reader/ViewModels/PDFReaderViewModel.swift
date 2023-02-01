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
    @Published private(set) var error: PDFReaderError?
    
    let reader: PDFReader
    
    init(reader: PDFReader) {
        self.reader = reader
    }
    
    enum PDFReaderError: Equatable {
        case chooseDialog(error: String)
        case pdfReader(error: String)
    }
    
    func readFile(from result: Result<URL, Error>) {
        switch result {
        case let .success(url):
            reader.readFile(from: url)
        case let .failure(error):
            self.error = .chooseDialog(error: error.localizedDescription)
        }
    }
}
