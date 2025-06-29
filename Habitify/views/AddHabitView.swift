import SwiftUI

struct AddHabitView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var category: String = "Health"
    @State private var createdAt: Date = Date()
    @State private var isArchived: Bool = false

    private let categoryOptions = ["Health", "Productivity", "Wellness", "Learning", "Other"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Title input
                    VStack(alignment: .leading) {
                        Text("Habit Title")
                            .font(.headline)
                        TextField("e.g. Drink Water", text: $title)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                    }

                    // Category picker
                    VStack(alignment: .leading) {
                        Text("Category")
                            .font(.headline)
                        Picker("Select Category", selection: $category) {
                            ForEach(categoryOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                    }

                    // Date picker
                    VStack(alignment: .leading) {
                        Text("Start Date")
                            .font(.headline)
                        DatePicker("", selection: $createdAt, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .frame(maxWidth: .infinity)
                    }

                    // Archive toggle
                    Toggle("Archive This Habit", isOn: $isArchived)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)

                    // Save button
                    Button(action: addHabit) {
                        Text("Save Habit")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(title.isEmpty)
                }
                .padding()
            }
            .navigationTitle("New Habit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func addHabit() {
        let newHabit = Habit(context: viewContext)
        newHabit.id = UUID()
        newHabit.title = title
        newHabit.category = category
        newHabit.createdAt = createdAt
        newHabit.isArchived = isArchived

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Failed to save habit: \(error.localizedDescription)")
        }
    }
}
