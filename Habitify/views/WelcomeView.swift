import SwiftUI

struct WelcomeView: View {
    @Binding var isActive: Bool
    @State private var currentPage = 0

    var body: some View {
        VStack(spacing: 50) {
            Spacer()
            
            Text("Habitify")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

            // adding pagers using TabView
            TabView(selection: $currentPage) {
                PagerView(
                    imageName: "logo",
                    title: "Track Your Habits",
                    subtitle: "Stay consistent with a personalized habit tracker."
                )
                .tag(0)

                PagerView(
                    imageName: "logo",
                    title: "Build Better Routines",
                    subtitle: "Achieve your goals with streaks and habit stats."
                )
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // hide default dots
            .frame(height: 300)
            .padding(.horizontal)

            // MARK: - Custom Page Indicators
            HStack(spacing: 8) {
                Circle()
                    .fill(currentPage == 0 ? Color.purple : Color.gray.opacity(0.3))
                    .frame(width: 10, height: 10)

                Circle()
                    .fill(currentPage == 1 ? Color.purple : Color.gray.opacity(0.3))
                    .frame(width: 10, height: 10)
            }

            Spacer()

            // MARK: - Buttons
            if currentPage == 0 {
                Button("Continue") {
                    withAnimation {
                        currentPage = 1
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
            } else {
                Button("Get Started") {
                    withAnimation {
                        isActive = true
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
            }
        }
        .padding()
    }
}

struct PagerView: View {
    let imageName: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 16) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)

            Text(title)
                .font(.title)
                .fontWeight(.bold)

            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

#Preview {
    StatefulPreviewWrapper(false) { isActive in
        WelcomeView(isActive: isActive)
    }
}
