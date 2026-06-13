//
//  QuoteOverlay.swift
//  HealthTracker Watch App2
//
//  Created by Reginald Grant on 6/8/26.
//

import SwiftUI

struct QuoteOverlayView: View {
    let quote: MotivationalQuote
    let isLoading: Bool
    let onDismiss: (() -> Void)
    
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                if isLoading {
                    ProgressView()
                }
            }
        }
    }
}
