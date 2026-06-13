//
//  MotuvationalQuoteService.swift
//  HealthTracker Watch App2
//
//  Created by Reginald Grant on 6/8/26.
//

import Foundation
import Combine

//Singleton
static let shared = MotivationalQuoteService()
private init() {}

//MARK: - API Config
private let apiURL: String = "https://zenquotes.io/api/random"

func fetchQuote() async -> MotivationalQuote {
    guard let url = URL(string: apiURL) else {
        // Fallback
    }
}
