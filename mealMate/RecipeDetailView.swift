//
//  RecipeDetailView.swift
//  mealMate
//
//  Created by jessiline imanuela on 27/05/24.
//
import SwiftUI
import SwiftData

struct RecipeDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var ayamData: [AyamData]
    @Binding var allIngredients: [String]
    @Environment(\.modelContext) private var context
    @State private var isNavigating = false


    var body: some View {
        VStack {
            if let item = ayamData.first {
                if let url = URL(string: "https://\(item.Url)") {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 320)
                                .clipped()
                        case .empty:
                            ProgressView()
                                .frame(height: 320)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 320)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "kambingguling")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 320)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                ZStack {
                    UnevenRoundedRectangle(topLeadingRadius: 35, topTrailingRadius: 35)
                        .foregroundColor(.white)
                        .padding(.top, -20)
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(capitalizeTitle(item.Title))
                                    .font(.system(size: 28))
                                    .fontWeight(.semibold)
                                Spacer()
                                ZStack {
                                    Circle()
                                        .frame(width: 48, height: 48)
                                        .foregroundColor(item.isClicked ? Color(red: 220/255, green: 38/255, blue: 38/255) : .white)
                                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 3)
                                    
                                    Image(systemName: "heart")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(item.isClicked ? .white : Color(red: 220/255, green: 38/255, blue: 38/255))
                                }
                                .onTapGesture {
                                    let index = ayamData.firstIndex(where: { $0.id == item.id })!
                                    ayamData[index].isClicked.toggle()                                }
                            }
                            .padding(.vertical, 15)
                            
                            Text("Need to Buy:")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .padding(.bottom, 1)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                ForEach(item.Ingredients.split(separator: "--").map(String.init), id: \.self) { ingredient in
                                    let trimmedIngredient = ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
                                    if !checkIfContainsItem(ingredient: trimmedIngredient) {
                                        Text("• \(trimmedIngredient)")
                                            .font(.system(size: 14))
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                            }
                            .padding(.bottom, 10)
                            
                            Text("Ingredients:")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .padding(.bottom, 1)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                ForEach(item.Ingredients.split(separator: "--").map(String.init), id: \.self) { ingredient in
                                    Text("• \(ingredient.trimmingCharacters(in: .whitespacesAndNewlines))")
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                            .padding(.bottom, 10)
                            
                            Text("Cooking Steps:")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .padding(.bottom, 2)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(item.Steps.split(separator: "--").map(String.init), id: \.self) { step in
                                    HStack(alignment: .top) {
                                        VStack {
                                            ZStack {
                                                Circle()
                                                    .fill(Color(red: 248/255, green: 235/255, blue: 235/255))
                                                    .frame(width: 25, height: 25)
                                                
                                                Circle()
                                                    .fill(Color(red: 250/255, green: 183/255, blue: 191/255))
                                                    .frame(width: 13, height: 13)
                                            }
                                            if step != item.Steps.split(separator: "--").map(String.init).last {
                                                Rectangle()
                                                    .fill(Color(red: 248/255, green: 235/255, blue: 235/255))
                                                    .frame(width: 3, height: 50)
                                                    .cornerRadius(2)
                                                    .padding(.top, -3)
                                            }
                                        }
                                        VStack(alignment: .leading) {
                                            Text(step.trimmingCharacters(in: .whitespacesAndNewlines))
                                                .multilineTextAlignment(.leading)
                                                .font(.system(size: 14))
                                                .fixedSize(horizontal: false, vertical: true)
                                                .lineLimit(nil)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 32)
                        .padding(.bottom, 20)
                    }
                }
                .padding(.top, -15)
                
                    Button(action: {
                        deleteAllDataItems()
                        isNavigating = true
                    }) {
                        Text("Done Cooking")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .frame(width: 330, height: 45)
                            .background(Color(red: 220/255, green: 38/255, blue: 38/255))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .padding(.top)
                    }
                    NavigationLink(destination: scanPage().navigationBarBackButtonHidden(true), isActive: $isNavigating) {
                       EmptyView()
                   }
                

                
                //                .onAppear {
                //                    print(allIngredients)
                //                }
                    .navigationBarItems(trailing:
                                            NavigationLink(destination: SavedItemsView(ayamData: $ayamData, allIngredients: $allIngredients).navigationBarTitle("Saved Items")) {
                        Text("Saved Items")
                    }
                    )
            }
        }
    }
    
    func capitalizeTitle(_ title: String) -> String {
        return title.capitalized
    }
    
    func cleanIngredient(_ ingredient: String) -> String {
        let wordsToRemove = ["daging", "ikan", "telur"]
        let words = ingredient.split(separator: " ").map { String($0).lowercased() }
        let cleanedWords = words.filter { !wordsToRemove.contains($0) }
        return cleanedWords.joined(separator: " ")
    }

    func cleanAllIngredients(_ ingredients: [String]) -> [String] {
        return ingredients.map { cleanIngredient($0) }
    }
    
    func checkIfContainsItem(ingredient: String) -> Bool {
        let cleanedAllIngredients = cleanAllIngredients(allIngredients)
        let words = ingredient.lowercased().split(separator: " ").map(String.init)
        for item in cleanedAllIngredients {
            if words.contains(where: { $0.contains(item) }) {
                print("Match found: \(item) in \(ingredient)")
                return true
            }
        }
        print("No match found for: \(ingredient)")
        return false
    }
    
    func deleteAllDataItems() {
        let fetchRequest = FetchDescriptor<DataItem>()
                    
        do {
            let items = try context.fetch(fetchRequest)
            for dataItem in items {
                context.delete(dataItem)
            }
            try context.save()
        } catch {
            print("Failed to delete items: \(error.localizedDescription)")
        }

    }

}
