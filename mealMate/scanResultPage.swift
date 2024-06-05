//
//  scanResultPage.swift
//  mealMate
//
//  Created by Vanessa on 28/05/24.
//

import SwiftUI
import SwiftUI
import CoreML
import Vision

struct scanResultPage: View {
    @Binding var names: [String]
    @Binding var image: UIImage?
    @Binding var isClicked: Bool
    @FocusState private var isTextFieldFocused: Bool
    
    @State private var classificationResults: [String] = []
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(20)
                    .scaledToFit()
                    .onAppear {
                        classifyImage(image)
                    }
            } else {
                Text("No image available")
            }
            Button(action: {
                names.append("")
                print(names)
            }) {
                HStack {
                    Text("Ingredients result:")
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "plus.circle")
                        .padding(.leading)
                    Text("Add")
                }
                .font(.callout)
                .foregroundColor(.red)
                .padding(.top, 30)
                .padding(.leading, 5)
                .padding(.horizontal)
            }
            ScrollView {
                VStack {
                    Spacer()
                    ForEach(classificationResults.indices, id: \.self) { index in
                        HStack {
                            TextField("Name", text: $classificationResults[index])
                                .padding(.vertical, 7)
                                .padding(.leading, 28)
                                .background(Color.white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 1)
                                        .padding(.leading, 18)
                                )
                            
                            Button(action: {
                                classificationResults.remove(at: index)
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                                    .padding(.trailing, 15)
                            }
                        }
                        .padding(.bottom, 10)
                        .focused($isTextFieldFocused)
                    }
                    ForEach(names.indices, id: \.self) { index in
                        HStack {
                            TextField("Name", text: $names[index])
                                .padding(.vertical, 7)
                                .padding(.leading, 28)
                                .background(Color.white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 1)
                                        .padding(.leading, 18)
                                )
                            
                            Button(action: {
                                names.remove(at: index)
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                                    .padding(.trailing, 15)
                            }
                        }
                        .padding(.bottom, 10)
                        .focused($isTextFieldFocused)
                    }
                    Spacer()
                }
                .onDisappear {
                    names = []
                    classificationResults = []
                }
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
            .font(.callout)
            
            NavigationLink(destination: ResultView(isClicked: $isClicked).navigationBarTitle("Recipe Result")) {
                CustomButton(text: "Generate Recipe")
                    .padding(.top)
            }
            .ignoresSafeArea()
            .opacity(isTextFieldFocused ? 0 : 1)
            .padding(.vertical, isTextFieldFocused ? -50 : 20)
            .padding(.horizontal)
        }
        .padding()
    }
    
    func classifyImage(_ uiImage: UIImage) {
        guard let model = try? VNCoreMLModel(for: proteindetection().model) else {
            print("Failed to load model")
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            if let error = error {
                print("Error during classification: \(error.localizedDescription)")
                return
            }
            
            if let results = request.results as? [VNRecognizedObjectObservation] {
                if results.isEmpty {
                    print("No results found.")
                } else {
                    var newResults: [String] = []
                    for observation in results {
                        if let topLabel = observation.labels.first {
                            let resultString = "\(topLabel.identifier)"
                            newResults.append(resultString)
                            print(resultString)
                        }
                    }
                    DispatchQueue.main.async {
                        self.classificationResults = newResults
                    }
                }
            } else {
                print("Failed to get results: \(String(describing: request.results))")
            }
        }
        
        guard let ciImage = CIImage(image: uiImage) else {
            print("Failed to convert UIImage to CIImage")
            return
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform classification: \(error.localizedDescription)")
            }
        }
    }
}
