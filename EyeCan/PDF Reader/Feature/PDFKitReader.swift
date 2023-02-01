//
//  PDFKitReader.swift
//  EyeCan
//
//  Created by Lev Litvak on 01.02.2023.
//

import PDFKit

class PDFKitReader: PDFReader {
    func readFile(from url: URL) -> Result<String, PDFReaderError> {
        guard url.startAccessingSecurityScopedResource() else { return .failure(.fileAccessError) }
        guard let pdf = PDFDocument(url: url) else { return .failure(.readFileError) }

        let pageCount = pdf.pageCount
        var documentContent = ""
        for pageNum in 0..<pageCount {
            guard let page = pdf.page(at: pageNum) else { continue }
            guard let pageContent = page.string else { continue }
            documentContent += pageContent
        }

        url.stopAccessingSecurityScopedResource()
        
        return .success(documentContent)
    }
}
