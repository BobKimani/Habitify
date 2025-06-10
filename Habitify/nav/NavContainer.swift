import SwiftUI

struct NavigationContainerView: View {
    @State private var isActive = false

    var body: some View {
        NavigationStack {
            if isActive {
                SignInView()
            } else {
                WelcomeView(isActive: $isActive)
            }
        }
    }
}

#Preview {
    NavigationContainerView()
}
