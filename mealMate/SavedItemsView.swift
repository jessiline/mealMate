//
//  SavedItemsView.swift
//  mealMate
//
//  Created by jessiline imanuela on 29/05/24.
//

import SwiftUI
import SwiftData
struct SavedItemsView: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    @Query private var items: [DataItem]
    @Environment(\.modelContext) private var context
    @Binding var ayamData: [AyamData]
    @Binding var allIngredients: [String]

    var body: some View {
        VStack{
            ScrollView{
                VStack(){
                    HStack{
                        Text("Temporary saved")
                            .padding(.leading,22)
                            .padding(.bottom,10)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 175))]) {
                        ForEach (items){ item in
                            NavigationLink(destination: RecipeDetailView(ayamData: [convertToAyamData(item)], allIngredients: $allIngredients ).navigationBarTitle("Recipe Details")) {
                                VStack{
                                    if let url = URL(string: "https://\(item.Url)") {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 165, height: 105)
                                        .clipShape(
                                            UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
                                        )
                                    
                                    }
                                    ZStack{
                                        UnevenRoundedRectangle(bottomLeadingRadius: 12, bottomTrailingRadius: 12)
                                            .frame(width: 165, height: 110)
                                            .foregroundColor(.white)
                                        VStack{
                                            HStack{
                                                Text(item.Title)
                                                    .font(.system(size: 14))
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.black)
                                                Spacer()
                                            }
                                            
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
                                                        .foregroundColor(item.isClicked ? .white : Color(red: 220/255, green: 38/255, blue: 38/255) )
                                                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 3)
                                                    
                                                    Image(systemName: "heart")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 18, height: 18)
                                                        .foregroundColor(item.isClicked ? Color(red: 220/255, green: 38/255, blue: 38/255) : .white)
                                                    
                                                }
                                                .onTapGesture {
                                                    let index = items.firstIndex(where: { $0.id == item.id })!
                                                    items[index].isClicked.toggle()
                                                    if items[index].isClicked {
                                                        deleteItem(item)
                                                    }
                                                }
                                                .padding(10)
                                            }
                                        }
                                        
                                    }
                                    .padding(.top,-9)
                                    .frame(maxWidth: 165)
                                    
                                    
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal)

                }
                .padding(.top,20)

            }

            .frame(maxWidth: .infinity)
            
            
        }
        .background(Color(red: 244/255, green: 244/255, blue: 244/255))
        .padding(.top,0.2)
    }
    func deleteItem(_ item: DataItem) {
        if let ayamIndex = ayamData.firstIndex(where: { $0.Title == item.Title }) {
            ayamData[ayamIndex].isClicked = false
        }
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("Failed to delete item: \(error.localizedDescription)")
        }
    }
    func convertToAyamData(_ item: DataItem) -> AyamData {
        return AyamData(Title: item.Title, Ingredients: item.Ingredients, Steps: item.Steps, Url: item.Url, isClicked: item.isClicked)
        }
}
