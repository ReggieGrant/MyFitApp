//
//  StepCardView.swift
//  MyFitApp
//
//  Created by Reginald Grant on 5/18/26.
//

import SwiftUI


// Child View
struct StepCardView: View {
    
    let goal:Int = 10000
    let steps:Int

    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            HStack{
                
                Image(systemName: "figure.walk.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
                
                Text("Current Steps").font(.headline)
                Spacer()
            }
            
            HStack(alignment: .firstTextBaseline){
                Text("\(steps)")
                    .font(.system(size: 48,weight: .bold))
                    .foregroundColor(.primary)
                
                Text("Steps ")
                    .font(.title)
                    .foregroundColor(.gray)
            }
            
            ProgressView(value: Double(steps), total: Double(goal))
                .tint(.green)
            
            Text("Goal \(goal.formatted()) Steps")
                .font(.caption)
                .foregroundColor(.gray)
            
        }.padding()
            .background(Color(.systemGray6))
            .cornerRadius(20)
            .padding()
        
        
    }
}


// Parent View
#Preview {
    StepCardView(steps:900)
}
