import SwiftUI

struct HabitView: View {
    var title: String
    var icon: String = "heart.fill"
    var habits: [String]
    @Binding var completedHabits: Set<String>

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label(title, systemImage: icon)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }

            ForEach(habits, id: \.self) { habit in
                HStack {
                    Text(habit)
                        .foregroundColor(.primary)
                    Spacer()
                    Button(action: {
                        toggle(habit)
                    }) {
                        Image(systemName: completedHabits.contains(habit) ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(completedHabits.contains(habit) ? .purple : .gray)
                    }
                }
                .padding(.vertical, 8)
                .contentShape(Rectangle()) // make entire row tappable
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }

    func toggle(_ habit: String) {
        if completedHabits.contains(habit) {
            completedHabits.remove(habit)
        } else {
            completedHabits.insert(habit)
        }
    }
}


