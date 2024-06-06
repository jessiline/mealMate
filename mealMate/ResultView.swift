//
//  ResultView.swift
//  mealMate
//
//  Created by jessiline imanuela on 28/05/24.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isClicked: Bool
    @State private var ayamData: [AyamData] = []
    @Binding var classificationResults: [String]
    @State private var shuffledData: [AyamData] = []

    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 175))]) {
                    ForEach(shuffledData.prefix(5)) { item in                            VStack {
                                Image("kambingguling")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 105)
                                    .clipShape(
                                        UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
                                    )
                                
                                ZStack{
                                    UnevenRoundedRectangle(bottomLeadingRadius: 12, bottomTrailingRadius: 12)
                                        .frame(width: 165, height: 110)
                                        .foregroundColor(.white)
                                    VStack{
                                        HStack{
                                            Text(item.Title) // Use item.Title here
                                                .font(.system(size: 14))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
//                                        HStack{
//                                            Text("102 Calories")
//                                                .font(.system(size: 12))
//                                                .foregroundColor(.gray)
//                                                .padding(.top,1)
//                                            Spacer()
//                                        }
                                        Spacer()
                                    }
                                    .padding(10)
                                    VStack(){
                                        Spacer()
                                        HStack{
                                            Spacer()
                                            ZStack {
                                                Circle()
                                                    .frame(width: 40, height: 40)
                                                    .foregroundColor(item.isClicked ? Color(red: 220/255, green: 38/255, blue: 38/255) : .white)
                                                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 3)
                                                
                                                Image(systemName: "heart")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 18, height: 18)
                                                    .foregroundColor(item.isClicked ? .white : Color(red: 220/255, green: 38/255, blue: 38/255))
                                                
                                            }
                                            .onTapGesture {
                                                shuffledData[shuffledData.firstIndex(where: { $0.id == item.id })!].isClicked.toggle()
                                            }
                                            .padding(10)
                                        }
                                    }
                                    
                                }
                                .padding(.top,-9)
                                .frame(maxWidth: 165)
                            }
                            .padding(.top)
                        }
                    }
                .padding(.horizontal)


            }

            .frame(maxWidth: .infinity)
            Spacer()
            
            
        }
        .background(Color(red: 244/255, green: 244/255, blue: 244/255))
        .padding(.top,0.2)
        .navigationBarItems(trailing:
                            NavigationLink(destination: SavedItemsView(isClicked: $isClicked).navigationBarTitle("Saved Items")) {
                Text("Saved Items")
            }
       )
        .onAppear {
            guard !classificationResults.isEmpty else {
             print("Tidak ada hasil klasifikasi yang tersedia")
             return
            }

            var filename = classificationResults[0]
            filename = filename.replacingOccurrences(of: "daging", with: "").trimmingCharacters(in: .whitespaces)
            filename = "dataset-\(filename)"
            self.ayamData = loadCSV(from: filename)
            shuffledData = ayamData.shuffled()

        }
    }
}

//#Preview {
//    ResultView()
//}
