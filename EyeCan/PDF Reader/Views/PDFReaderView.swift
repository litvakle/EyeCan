//
//  PDFReaderView.swift
//  EyeCan
//
//  Created by Lev Litvak on 01.02.2023.
//

import SwiftUI

struct PDFReaderView: View {
    let text: String
    let onFileHasBeenChosen: (Result<URL, Error>) -> Void

    @State private var showChooseFileDialog = false
    
    var body: some View {
        VStack {
            title
            chooseFileButton
            fileContent
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
    }
    
    var chooseFileButton: some View {
        Button {
            showChooseFileDialog = true
        } label: {
            Text("Choose PDF file")
        }
        .buttonStyle(.bordered)
    }
    
    var fileContent: some View {
        ScrollView {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder()
                .foregroundColor(.secondary)
        }
    }
}

struct PDFReaderView_Previews: PreviewProvider {
    static var previews: some View {
        PDFReaderView(text: "Any text ", onFileHasBeenChosen: { _ in })
    }
}
