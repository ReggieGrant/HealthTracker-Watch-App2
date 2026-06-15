//
//  MotivationalQuote.swift
//  HealthTracker Watch App2
//
//  Created by Reginald Grant on 6/8/26.
//

import Foundation
import Combine

struct MotivationalQuote: Codable {
    let quote: String
    let author: String
    
    struct APIResponse: Codable {
        let q: String
        let a: String
    }
    
}
