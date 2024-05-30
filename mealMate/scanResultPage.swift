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

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
            } else {
                Text("No image available")
            }

            ScrollView {
                VStack {
                    Button(action: {
                        names.append("")
                        print(names)
                    }) {
                        HStack {
                            Spacer()
                            Image(systemName: "plus.circle")
                                .padding(.leading)
                            Text("Add")
                        }
                        .foregroundColor(.red)
                        .padding(.top, 30)
                        .padding(.bottom, 25)
                        .padding(.leading, 5)
                    }

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
                    }
                }
                .padding(.horizontal) 
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
            .font(.callout)
            
            NavigationLink(destination: scanPage().navigationBarBackButtonHidden(true)) {
                HStack {
                    Text("Generate Recipe")
                        .fontWeight(.bold)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: "DC2626"))
                .foregroundColor(.white)
                .cornerRadius(30)
            }
            .ignoresSafeArea()
            .padding(.horizontal)
            .padding(.bottom, 50)
        }
        .padding()
    }
}


