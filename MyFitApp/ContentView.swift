//
//  ContentView.swift
//  MyFitApp
//
//  Created by Reginald Grant on 5/18/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: HealthViewModel = HealthViewModel()
    
    
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing:20){
                    
                    HeaderSectionView()
                    StepCardView(steps: viewModel.steps)
                    DistanceCardView(distance: viewModel.distance)
                    CalorieCardView(calories: viewModel.calories)
                    ActivityStatusCardView(activityStatus: viewModel.activityStatus, authStatus: viewModel.authStatus, isAuth: viewModel.isAuth)
                    Spacer()
                }
                .padding()
                
            }
            .navigationTitle("Heath Tracker")
            .onAppear{
                viewModel.requestAuthorization()
            }
            .refreshable {
                viewModel.fetchTodaySteps()
                viewModel.fetchTodayDistance()
                viewModel.fetchTodayCalories()
            }
            
        }
    }
}

#Preview {
    ContentView()
}

