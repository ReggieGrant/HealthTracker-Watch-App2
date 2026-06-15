//
//  MainDashboardView.swift
//  HealthTracker Watch App2
//
//  Created by Reginald Grant on 6/7/26.
//

import SwiftUI

struct MainDashboardView: View {
    @ObservedObject var healthViewModel: HealthViewModel
    
    let ringSize = 60.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // MARK: - Header
                Text("Today")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
                
                // MARK: - Progress Rings Row
                HStack(spacing: 16) {
                    VStack (spacing: 6) {
                        ProgressRingView(
                            color: EntryType.calories.color,
                            progress: healthViewModel.caloriesProgress,
                            icon: EntryType.calories.icon,
                            size: ringSize
                        )
                        
                        Text("\(Int(healthViewModel.todaysCalories))")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(EntryType.calories.color)
                        
                        Text("/ \(Int(healthViewModel.goals.dailyCaloriesGoal))")
                            .font(.system(size: 9, design: .rounded))
                            .foregroundColor(.gray)
                    }
                    
                    VStack (spacing: 6) {
                        ProgressRingView(
                            color: EntryType.water.color,
                            progress: healthViewModel.waterProgress,
                            icon: EntryType.water.icon,
                            size: ringSize
                        )
                        
                        Text("\(Int(healthViewModel.todaysWater))")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(EntryType.water.color)
                        
                        Text("/ \(Int(healthViewModel.goals.dailyWaterGoal))")
                            .font(.system(size: 9, design: .rounded))
                            .foregroundColor(.gray)
                    }
                }
                
                HStack(spacing: 12) {
                    NavigationLink(destination: AddEntryView(healthViewModel: healthViewModel, entryType: .calories)) {
                        QuickAddButton(
                            icon: EntryType.calories.icon,
                            label: "Calories",
                            color: EntryType.calories.color
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: AddEntryView(healthViewModel: healthViewModel, entryType: .water)) {
                        QuickAddButton(
                            icon: EntryType.water.icon,
                            label: "Water",
                            color: EntryType.water.color
                        )
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                
                NavigationLink(destination: GoalsSettingsView(viewModel: healthViewModel)) {
                    HStack {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 12))
                        Text("Goals")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.gray)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 4)
            }
            .frame(maxWidth: .infinity)
        }
        .overlay {
            if healthViewModel.showQuoteOverlay {
                QuoteOverlayView(
                    quote: healthViewModel.currentQuote,
                    isLoading: healthViewModel.isLoadingQuote,
                    onDismiss: {
                        healthViewModel.showQuoteOverlay = false
                    }
                )
            }
        }
    }
}
