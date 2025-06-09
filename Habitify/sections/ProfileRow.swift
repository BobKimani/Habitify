import SwiftUI

struct ProfileRow: View {
    let icon: String
    let label: String
    var isDestructive: Bool = false

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(isDestructive ? .red : .purple)

            Text(label)
                .foregroundColor(isDestructive ? .red : .primary)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
    }
}
