//
//  scanPage.swift
//  mealMate
//
//  Created by Vanessa on 27/05/24.
//

import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraView
        
        init(parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.isShown = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.allowsEditing = false
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct CameraViewContainer: View {
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    var body: some View {
        CameraView(isShown: $isShown, image: $image)
            .ignoresSafeArea()
    }
}

struct scanPage: View {
    @State private var showCamera = false
    @State private var capturedImage: UIImage?
    @State private var showAlert = false
    @State private var navigateToResultPage = false
    @State private var names: [String] = []
    @Binding var isClicked: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Image("groupscan")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Text("Scan")
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding([.top, .leading], 40.0)
                        Spacer()
                        NavigationLink(destination: SavedItemsView(isClicked: $isClicked).navigationBarTitle("Recipe Result")) {
                            Text("Saved items")
                                .font(.system(size: 17))
                                .padding([.top, .trailing], 40.0)
                                .foregroundColor(.red)
                        }
                        
                    }
                    Spacer()
                }
                
                VStack {
                    Image("scanlogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 10.0)
                        .frame(width: 100, height: 80)
                    
                    Text("Start scanning your ingredients!")
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.vertical,20)
                    
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("Scan")
                            .fontWeight(.medium)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "DC2626"))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding(.horizontal, 30)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Scan your ingredients"),
                          /*  message: Text("Place all your ingredients together and scan them in one go.")*/
                            message: Text("Switch your camera to landscape mode to take the photo."),
                            primaryButton: .default(Text("OK")) {
                                showCamera = true
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                
                NavigationLink(destination: scanResultPage(names: $names, image: $capturedImage, isClicked: $isClicked).navigationBarTitle("Scan Result"), isActive: $navigateToResultPage) {
                    EmptyView()
                }
              
            }
            .fullScreenCover(isPresented: $showCamera, onDismiss: {
                if capturedImage != nil {
                    navigateToResultPage = true
                }
            }) {
                CameraViewContainer(isShown: $showCamera, image: $capturedImage)
                    .ignoresSafeArea()
            }
        }
        .accentColor(Color.red)
    }
}
//
//#Preview {
//    scanPage()
//}
