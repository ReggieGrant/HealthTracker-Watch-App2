//
//  HealthTrackerViewModel.swift
//  HealthTracker Watch App2
//
//  Created by Reginald Grant on 6/7/26.
//

import Foundation
import Combine
import WatchKit

class HealthViewModel: ObservableObject {

    // MARK: - Published Variables
    @Published var todaysWater: Double = 0
    @Published var todaysCalories: Double = 0

    @Published var goals: UserGoals

    @Published var currentQuote: MotivationalQuote?
    @Published var isLoadingQuote: Bool = false
    @Published var showQuoteOverlay: Bool = false

    @Published var latestHeartRate: HeartRateSample?
    @Published var heartRateErrors: String?
    @Published var isHealthKitAvailable: Bool = false

    // MARK: - Services/Managers
    private let storageManager = StorageManager.shared
    private let motivationalQuoteService = MotivationalQuoteService.shared
    private let healthKitManager = HealthKitManager.shared


    init() {
        self.goals = storageManager.loadCurrentGoals()
        refreshDailyTotals()
        isHealthKitAvailable = healthKitManager.isHealthDataAvailable
    }

    // MARK: - Computed Properties
    var formattedHeartRate: String {
        guard let bpm = latestHeartRate?.bpm else { return "--" }
        return "\(Int(bpm)) BPM"
    }

    var caloriesProgress: Double {
        guard goals.dailyCaloriesGoal > 0 else { return 0 }
        return min(todaysCalories / goals.dailyCaloriesGoal, 1.0)
    }

    var waterProgress: Double {
        guard goals.dailyWaterGoal > 0 else { return 0 }
        return min(todaysWater / goals.dailyWaterGoal, 1.0)
    }

    // MARK: - HealthKit
    func requestHealthKitAuthorization() async {
        do {
            try await healthKitManager.requestAuthorization()
            await MainActor.run {
                self.isHealthKitAvailable = self.healthKitManager.isHealthDataAvailable
                self.heartRateErrors = nil
            }
        } catch {
            await MainActor.run {
                self.heartRateErrors = error.localizedDescription
            }
        }
    }
    
    // MARK: - Methods Goals
    func updateGoals(calories: Double, water: Double) {
        goals = UserGoals(
            dailyCaloriesGoal: calories, dailyWaterGoal: water
        )
        storageManager.saveNewGoals(goals)
        WKInterfaceDevice.current().play(.success)
    }
    
    // MARK: - Methods Diary Entries
    func refreshDailyTotals() {
        todaysCalories = storageManager.getTodayTotal(for: .calories)
        todaysWater = storageManager.getTodayTotal(for: .water)
    }
    
    func addCalories(_ amount: Double) {
        let entry = DiaryEntry(
            type: .calories,
            value: amount
        )
        storageManager.addEntry(entry)
        
        fetchQuoteAfterEntry()
    }
    
    func addWater(_ amount: Double) {
        let entry = DiaryEntry(
            type: .water,
            value: amount
        )
        storageManager.addEntry(entry)
        
        fetchQuoteAfterEntry()
    }

    // MARK: - Methods Motivational Quotes
    func fetchQuoteAfterEntry() {
        isLoadingQuote = true
        showQuoteOverlay = true
        
        Task {
            currentQuote = await motivationalQuoteService.fetchQuote()
            isLoadingQuote = false
            
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            showQuoteOverlay = false
        }
    }
}
