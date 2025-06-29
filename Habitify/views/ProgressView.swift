// MARK: - ProgressView.swift

import SwiftUI
import CoreData
import Charts

struct ProgressView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var progressViewModel: ProgressViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel

    init(context: NSManagedObjectContext) {
        _progressViewModel = StateObject(wrappedValue: ProgressViewModel(context: context))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    header
                    weeklyCompletion
                    pieChartSection
                    calendarSection
                    streakSection
                }
                .padding()
            }
            .navigationTitle("Progress")
        }
    }

    private var header: some View {
        HStack {
            Label("Hi, \(authViewModel.displayName)", systemImage: "person.circle")
                .font(.headline)

            Spacer()

            HStack(spacing: 16) {
                Image(systemName: "bell")
                Image(systemName: "info.circle")
            }
            .font(.title3)
        }
    }

    private var weeklyCompletion: some View {
        SectionCard(title: "Weekly Completion") {
            if progressViewModel.totalCompletionsThisWeek == 0 {
                Text("No habits completed this week.")
                    .foregroundColor(.gray)
            } else {
                ForEach(progressViewModel.weeklyStats.sorted(by: { $0.key < $1.key }), id: \ .key) { category, count in
                    ProgressBarRow(
                        label: category,
                        percent: CGFloat(count) / CGFloat(progressViewModel.totalCompletionsThisWeek)
                    )
                }
            }
        }
    }

    private var pieChartSection: some View {
        SectionCard(title: "Category Distribution") {
            if progressViewModel.categoryDistribution.isEmpty {
                Text("No data to display")
                    .foregroundColor(.gray)
            } else {
                Chart {
                    ForEach(progressViewModel.categoryDistribution.sorted(by: { $0.key < $1.key }), id: \ .key) { category, count in
                        SectorMark(
                            angle: .value("Count", count),
                            innerRadius: .ratio(0.5),
                            angularInset: 1
                        )
                        .foregroundStyle(by: .value("Category", category))
                    }
                }
                .frame(height: 200)
            }
        }
    }

    private var calendarSection: some View {
        SectionCard(title: "Calendar") {
            CalendarGridView(completionDates: progressViewModel.completionDates)
        }
    }

    private var streakSection: some View {
        SectionCard(title: "Streaks") {
            HStack {
                VStack(alignment: .leading) {
                    Text("🔥 Current Streak")
                    Text("\(progressViewModel.currentStreak) days")
                        .font(.headline)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("🏆 Best Streak")
                    Text("\(progressViewModel.bestStreak) days")
                        .font(.headline)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProgressView(context: PersistenceController.preview.container.viewContext)
        .environmentObject(AuthViewModel())
}
