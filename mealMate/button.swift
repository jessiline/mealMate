//
//  button.swift
//  mealMate
//
//  Created by jessiline imanuela on 27/05/24.
//

import SwiftUI
struct CustomButton: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 14))
            .fontWeight(.medium)
            .frame(width: 330, height: 45)
            .background(Color(red: 220/255, green: 38/255, blue: 38/255))
            .foregroundColor(.white)
            .cornerRadius(30)
            
    }
}
