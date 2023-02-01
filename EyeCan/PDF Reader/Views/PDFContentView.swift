//
//  PDFContentView.swift
//  EyeCan
//
//  Created by Lev Litvak on 01.02.2023.
//

import SwiftUI
import PDFKit

struct PDFContentView : UIViewRepresentable {
    private var data: Data?
    private let autoScales : Bool
    
    init(data : Data?, autoScales : Bool = true ) {
        self.data = data
        self.autoScales = autoScales
    }

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()

        pdfView.autoScales =  self.autoScales
       
        if let data = self.data {
            pdfView.document = PDFDocument(data: data)
        }
        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        if let data = self.data {
            uiView.document = PDFDocument(data: data)
        }
    }
}
