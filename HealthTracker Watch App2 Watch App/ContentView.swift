//
//  ContentView.swift
//  HealthTracker Watch App2 Watch App
//
//  Created by Reginald Grant on 6/7/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HealthViewModel()
    
    var body: some View {
        NavigationStack {
            MainDashboardView(viewModel: viewModel)
        }.onAppear {
            viewModel.refreshTodaysData()
        }
    }
}

#Preview {
    ContentView()
}
