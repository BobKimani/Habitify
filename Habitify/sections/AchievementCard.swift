import SwiftUI

struct AchievementCard: View {
    let title: String
    let description: String
    let unlocked: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(unlocked ? .primary : .gray)

            Text(description)
                .font(.subheadline)
                .foregroundColor(unlocked ? .secondary : .gray)

            if unlocked {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.green)
            } else {
                Image(systemName: "lock.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
