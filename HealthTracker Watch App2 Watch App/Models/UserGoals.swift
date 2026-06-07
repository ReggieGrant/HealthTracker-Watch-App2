//
//  UserGoals.swift
//  HealthTracker Watch App2
//
//  Created by Reginald Grant on 6/7/26.
//

import Foundation

struct UserGoals: Codable {
    var dailyCaloriesGoal: Double
    var dailyWaterGoal: Double
    
    static let defaultGoals = UserGoals(
        dailyCaloriesGoal: 2000,
        dailyWaterGoal: 2000
    )
}
