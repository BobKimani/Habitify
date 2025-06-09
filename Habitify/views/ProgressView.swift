// Views/Progress/ProgressView.swift
import SwiftUI

struct ProgressView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    HStack {
                        Label("Hi, Alex", systemImage: "person.circle")
                            .font(.headline)
                        Spacer()
                        HStack(spacing: 16) {
                            Image(systemName: "bell")
                            Image(systemName: "info.circle")
                        }
                        .font(.title3)
                    }
                    .padding(.horizontal)

                    // Streaks
                    StreaksView()

                    // Weekly Completion
                    SectionCard(title: "Weekly Completion") {
                        ProgressBarRow(label: "Health", percent: 0.86)
                        ProgressBarRow(label: "Productivity", percent: 0.65)
                        ProgressBarRow(label: "Personal", percent: 0.73)
                    }

                    // Calendar Section
                    SectionCard(title: "Calendar") {
                        CalendarView()
                    }

                    // Monthly Progress
                    SectionCard(title: "Monthly Progress") {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 140)
                            .overlay(
                                Text("[Monthly Progress Chart]")
                                    .foregroundColor(.gray)
                            )
                    }

                    // Habit Success Rate
                    SectionCard(title: "Habit Success Rate") {
                        ProgressBarRow(label: "Morning Exercise", percent: 0.92)
                        ProgressBarRow(label: "Deep Work", percent: 0.75)
                        ProgressBarRow(label: "Meditation", percent: 0.69)
                    }

                    Spacer(minLength: 30)
                }
                .padding()
            }
            .navigationTitle("Progress")
        }
    }
}

#Preview {
    NavigationStack {
        BottomNavView()
    }
}
