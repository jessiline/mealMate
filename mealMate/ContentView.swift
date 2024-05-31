//
//  ContentView.swift
//  mealMate
//
//  Created by jessiline imanuela on 27/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            NavigationLink(destination: ResultView().navigationBarTitle("Recipe Result")) {
                Text("Recipe Result")
            }
        }
        .accentColor(Color.red)

    }
}

#Preview {
    ContentView()
}
