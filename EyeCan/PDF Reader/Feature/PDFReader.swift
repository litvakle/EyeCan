//
//  PDFReader.swift
//  EyeCan
//
//  Created by Lev Litvak on 01.02.2023.
//

import Foundation

protocol PDFReader {
    func readFile(from url: URL) -> Result<String, PDFReaderError>
}

enum PDFReaderError: Error {
    case fileAccessError
    case readFileError
}
