import SwiftUI

struct AchievementCard: View {
    let title: String
    let description: String
    let unlocked: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(unlocked ? .primary : .gray)
                Spacer()
                Image(systemName: unlocked ? "checkmark.seal.fill" : "lock.fill")
                    .foregroundColor(unlocked ? .green : .gray)
            }

            Text(description)
                .font(.subheadline)
                .foregroundColor(unlocked ? .secondary : .gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
