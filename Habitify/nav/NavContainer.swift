import SwiftUI

struct NavContainer: View {
    @State private var navigateToSignIn = false

    var body: some View {
        NavigationStack {
            WelcomeView(isActive: $navigateToSignIn)
                .navigationDestination(isPresented: $navigateToSignIn) {
                    SignInView()
                }
        }
    }
}
