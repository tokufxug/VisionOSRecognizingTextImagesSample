//
//  ContentView.swift
//  VisionOSRecognizingTextImagesSample
//
//  Created by Sadao Tokuyama on 3/29/24.
//

import SwiftUI
import Vision

struct ContentView: View {
    
    @State var uiImage: UIImage = UIImage(named: "image")!
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: 800)
            Text(text)
            Button(action: {
                recognizeText(uiImage)
            }) {
                Text("Recognize Text")
            }
        }
        .padding()
    }
    
    func recognizeText(_ uiImage:UIImage) {
        guard let cgImage = uiImage.cgImage else { return }
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        request.revision = VNRecognizeTextRequestRevision3
        request.recognitionLanguages = ["ja", "en"]
        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
    }
    
    func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations =
                request.results as? [VNRecognizedTextObservation] else {
            return
        }
        let recognizedStrings = observations.compactMap { observation in
            return observation.topCandidates(1).first?.string
        }
        text = recognizedStrings.joined(separator: ",")
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
