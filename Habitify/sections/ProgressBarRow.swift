import SwiftUI

struct ProgressBarRow: View {
    let label: String
    let percent: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label)
                Spacer()
                Text("\(Int(percent * 100))%")
                    .foregroundColor(.gray)
            }

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 10)
                Capsule()
                    .fill(Color.purple)
                    .frame(width: UIScreen.main.bounds.width * 0.8 * percent, height: 10)
            }
        }
    }
}
