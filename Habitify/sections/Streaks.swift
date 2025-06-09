import SwiftUI

struct StreaksView: View {
    var body: some View {
        HStack(spacing: 16) {
            streakCard(value: "6", label: "Current Streak")
            streakCard(value: "21", label: "Longest Streak")
            streakCard(value: "94%", label: "Consistency")
        }
        .frame(maxWidth: .infinity)
    }

    func streakCard(value: String, label: String) -> some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
