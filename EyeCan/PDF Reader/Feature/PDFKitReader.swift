//
//  PDFKitReader.swift
//  EyeCan
//
//  Created by Lev Litvak on 01.02.2023.
//

import PDFKit

class PDFKitReader: PDFReader {
    func readFile(from url: URL) -> Result<Data, PDFReaderError> {
        guard url.startAccessingSecurityScopedResource() else { return .failure(.fileAccessError) }
        guard let pdf = PDFDocument(url: url) else { return .failure(.readFileError) }
        guard let data = pdf.dataRepresentation() else { return .failure(.readFileError) }
        url.stopAccessingSecurityScopedResource()
        
        return .success(data)
    }
}
