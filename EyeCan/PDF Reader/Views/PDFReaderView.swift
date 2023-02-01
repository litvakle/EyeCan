//
//  PDFReaderView.swift
//  EyeCan
//
//  Created by Lev Litvak on 01.02.2023.
//

import SwiftUI
import PDFKit

struct PDFReaderView: View {
    let pdfContent: PDFContentView
    let onFileHasBeenChosen: (Result<URL, Error>) -> Void

    @State private var showChooseFileDialog = false
    
    var body: some View {
        VStack {
            title
            chooseFileButton
            pdfContent
        }
        .padding(.horizontal)
        .fileImporter(
            isPresented: $showChooseFileDialog,
            allowedContentTypes: [.pdf],
            onCompletion: onFileHasBeenChosen
        )
    }
    
    var title: some View {
        Text("PDF Reader")
            .font(.largeTitle)
            .accessibilityAddTraits(.isHeader)
    }
    
    var chooseFileButton: some View {
        Button {
            showChooseFileDialog = true
        } label: {
            Text("Choose PDF file")
        }
        .buttonStyle(.bordered)
    }
}


struct PDFReaderView_Previews: PreviewProvider {
    static var previews: some View {
        PDFReaderView(pdfContent: PDFContentView(data: nil), onFileHasBeenChosen: { _ in })
    }
}
