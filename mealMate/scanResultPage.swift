//
//  scanResultPage.swift
//  mealMate
//
//  Created by Vanessa on 28/05/24.
//

import SwiftUI

struct scanResultPage: View {
    @Binding var names: [String]
    @Binding var image: UIImage?
    @Binding var isClicked: Bool
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(20)
                    .scaledToFit()

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

                    ForEach(names.indices, id: \.self) { index in
                        HStack {
                            TextField("Name", text: $names[index])
                                .padding(.vertical, 7)
                                .padding(.leading, 30)
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
//                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
            .font(.callout)
            
            NavigationLink(destination: ResultView( isClicked: $isClicked).navigationBarTitle("Recipe Result")) {
                CustomButton(text: "Generate Recipe")
                    .padding(.top)
            }
            .ignoresSafeArea()
            .opacity(isTextFieldFocused ? 0 : 1)
                                .padding(.vertical, isTextFieldFocused ? -50 : 20)
            .padding(.horizontal)
//            .padding(.bottom, 50)
        }
        .padding()
    }
}


