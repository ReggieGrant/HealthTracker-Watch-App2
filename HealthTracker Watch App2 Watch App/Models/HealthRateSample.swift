//
//  HealthRateSample.swift
//  HealthTracker Watch App2
//
//  Created by Reginald Grant on 6/7/26.
//

import Foundation
import Combine

struct HeartRateSample: Identifiable {
    let id = UUID()
    let bpm: Double
    let timestamp: Date
}
