//
//  PDFReader.swift
//  EyeCan
//
//  Created by Lev Litvak on 01.02.2023.
//

import Foundation

protocol PDFReader {
    func readFile(from url: URL) -> Result<Data, PDFReaderError>
}

enum PDFReaderError: Error, CaseIterable {
    case fileAccessError
    case readFileError
}
