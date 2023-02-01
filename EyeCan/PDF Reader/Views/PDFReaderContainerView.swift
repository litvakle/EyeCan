//
//  PDFReaderContainerView.swift
//  EyeCan
//
//  Created by Lev Litvak on 01.02.2023.
//

import SwiftUI

struct PDFReaderContainerView: View {
    @StateObject var vm = PDFReaderViewModel(reader: PDFKitReader())
    
    var body: some View {
        PDFReaderView(text: vm.text, onFileHasBeenChosen: vm.readFile)
            .alert("Error", isPresented: $vm.showError) {
                Button("OK", action: {})
            } message: {
                Text(vm.error?.message ?? "")
            }
    }
}
