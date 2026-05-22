//
//  HeaderSectionView.swift
//  MyFitApp
//
//  Created by Reginald Grant on 5/18/26.
//

import SwiftUI

struct HeaderSectionView: View {
    var body: some View {
        
        VStack(spacing:10) {
            Image(systemName: "figure.walk")
                .font(.system(size:80))
                .foregroundColor(.blue)
            
            Text("Daily Activity Tracker")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Monitor Healh Data")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    HeaderSectionView()
}
