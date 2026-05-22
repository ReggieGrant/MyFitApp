//
//  ActivityStatusCardView.swift
//  MyFitApp
//
//  Created by Reginald Grant on 5/18/26.
//

import SwiftUI

struct ActivityStatusCardView: View {
    
    let activityStatus:String
    let authStatus:String
    let isAuth:Bool 
    
    var body: some View {
        VStack(alignment:.leading, spacing:15){
            
            HStack{
                Image(systemName: "heart.circle.fill")
                    .font(.title2)
                    .foregroundColor(.red)
                
                Text("Activity Status")
                    .font(.headline)
                
                Spacer()
            }
            HStack{
                Text("Status")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text("\(activityStatus)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            
            HStack{
                Text("Authorization status")
                    .font(.body)
                    .foregroundColor(.gray)
                
                Text(authStatus)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(isAuth ? .green : .orange)
            }
            
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

//#Preview {
//    VStack(spacing:20){
//        ActivityStatusCardView(activityStatus: "Active", authStatus: "Authorized", isAuth: true)
//        
//        ActivityStatusCardView(activityStatus: "Normal", authStatus: "Not Authorized", isAuth: true)
//        
//        
//    }.padding()
//        
//}

