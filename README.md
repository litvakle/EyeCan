# EyeCan PDF Reader

## About

Test project for EyeCan.

I used the SwiftUI framework to build the UI Part of the App. At first, I created a custom view for displaying the content of PDF files. It worked with voiceover, but it was impossible to navigate through the text.
Then I realized we could use PDFView from PDFKit and translate it into the SwiftUI view - it works correctly and has full voiceover support "out of the box."

I partially used the TDD approach to develop it. I didn't make tests for Views. We can always use the ViewInspector library to test SwiftUI views if necessary.

Please, consider this a proof of concept, not a final product. I'm sure there are many little things to improve to make this feature more comfortable for blind people.

## Demonstration


