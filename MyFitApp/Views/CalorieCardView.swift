//
//  CalorieCardView.swift
//  MyFitApp
//
//  Created by Reginald Grant on 5/22/26.
//

import SwiftUI

struct CalorieCardView: View {
    let calories: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "flame.circle.fill")
                    .font(.system(size: 33))
                    .foregroundColor(.orange)
                
                Text("Calories Burned")
                    .font(.headline)
                
                Spacer()
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text("\(Int(calories.rounded()))")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("Kcal")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    CalorieCardView(calories: 450)
}
