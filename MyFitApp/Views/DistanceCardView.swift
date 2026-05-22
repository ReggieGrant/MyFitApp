//
//  DistanceCardView.swift
//  MyFitApp
//
//  Created by Reginald Grant on 5/18/26.
//

import SwiftUI

struct DistanceCardView: View {
    
    let distance:Double
    
    var body: some View {
        VStack(alignment: .leading, spacing:15){
            
            HStack{
                Image(systemName: "map.circle.fill")
                    .font(.system(size: 33))
                    .foregroundColor(.blue)
                
                Text("Distance")
                    .font(.headline)
                
                Spacer()
            }
            
            HStack(alignment: .firstTextBaseline){
                Text(String(format: "%.2f", distance))
                    .font(.system(size: 48,weight: .bold))
                    .foregroundColor(.primary)
                
                Text("Km")
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
    DistanceCardView(distance: 20.100)
}
