//
//  HealthViewModel.swift
//  MyFitApp
//
//  Created by Reginald Grant on 5/18/26.
//

import Foundation
import HealthKit // Apples framework to get health data
import Combine


class HealthViewModel: ObservableObject {
    @Published var steps: Int = 1000
    @Published var distance: Double = 30.120
    @Published var calories: Double = 0.0
    @Published var activityStatus: String = "Active"
    @Published var authStatus: String = "Authorized"
    @Published var isAuth: Bool = true
    
    private let healthStore:HKHealthStore = HKHealthStore()
    
    init(){
        // Health DATA sensors is avalible
    }
    
    // MARK: Check for data
    // isSomething -> RETURNS BOOLEAN
    // Some apple devices don't have the HealthKit App -> (iPad,Mac,Simulator)
    
    private func checkHealthDataAvailability() {
        if HKHealthStore.isHealthDataAvailable() {
            print("Health data is available")
        } else {
            print("Health data not available")
            authStatus = "Not Available"
        }
    }
    
    private func updateActivityStatus(){
        
        if steps < 2000 {
            activityStatus = "Sedentary"
        } else if steps < 5000 {
            activityStatus = "Lightly Active"
        } else if steps < 7000 {
            activityStatus = "Moderately Active"
        } else if steps < 10000 {
            activityStatus = "Active"
        } else if steps >=  10000 {
            activityStatus = "Very Active"
    }
        
        
}
    
    
    func requestAuthorization(){
        
        
        let typeToRead:Set<HKObjectType> = [
            
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
            
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: typeToRead) { success, error in
            DispatchQueue.main.async {
                if success {
                    self.isAuth = true
                    self.authStatus = "Authrozied"
                    
                    //Fetch metrics
                    self.fetchTodaySteps()
                    self.fetchTodayDistance()
                    self.fetchTodayCalories()
                    
                } else {
                    self.isAuth = false
                    self.authStatus = "Denied"
                    
                    if let error = error{
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    
    func fetchTodaySteps(){
        
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            print("No Steps / not available")
            return
        }
        
        let now = Date()
        let startOfTheDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfTheDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) {
            query,result,error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Error Fetching Steps: \(error.localizedDescription)")
                    self.steps = 0
                    
                    return
                }
                
                if let result = result , let sum = result.sumQuantity(){
                    
                    let steps = Int(sum.doubleValue(for: .count()))
                    self.steps = steps
                    self.updateActivityStatus()
                    print("Fetch: \(steps)")
                } else {
                    self.steps = 0
                    self.updateActivityStatus()
                }
            }
        }
        
        healthStore.execute(query)
        
        
        
    }
    
    func fetchTodayDistance(){
        guard let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            print("Distance walking/running not available")
            return
        }
        
        let now = Date()
        let startOfTheDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfTheDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) {
            query,result,error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Error Fetching Distance: \(error.localizedDescription)")
                    self.distance = 0.0
                    return
                }
                
                if let result = result, let sum = result.sumQuantity() {
                    let distanceInMeters = sum.doubleValue(for: .meter())
                    let distanceInKilometers = distanceInMeters / 1000
                    self.distance = distanceInKilometers
                    print("KM: \(distanceInKilometers) . \(distanceInMeters)")
                } else {
                    self.distance = 0.0
                }
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchTodayCalories(){
        guard let calorieType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("Active energy burned not available")
            return
        }
        
        let now = Date()
        let startOfTheDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfTheDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: calorieType, quantitySamplePredicate: predicate, options: .cumulativeSum) {
            query,result,error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Error Fetching Calories: \(error.localizedDescription)")
                    self.calories = 0.0
                    return
                }
                
                if let result = result, let sum = result.sumQuantity() {
                    self.calories = sum.doubleValue(for: .kilocalorie())
                    print("Calories: \(self.calories)")
                } else {
                    self.calories = 0.0
                }
            }
        }
        
        healthStore.execute(query)
    }
    
    func startObservingSteps(){
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            print("No Steps / not available")
            return
        }
        
        let query = HKObserverQuery(sampleType: stepCountType, predicate: nil) { query, completionHandler, error in
            
            
            if let error = error {
                print ("Error: \(error.localizedDescription)")
                return
            }
            
            self.fetchTodaySteps()
            self.fetchTodayDistance()
            self.fetchTodayCalories()
            
            completionHandler()
        }
        
        healthStore.execute(query)
    }
}
