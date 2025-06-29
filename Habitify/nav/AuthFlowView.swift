import SwiftUI

struct AuthFlowView: View {
    @State private var showSignIn = false

    var body: some View {
        NavigationStack {
            WelcomeView(isActive: $showSignIn)
                .navigationDestination(isPresented: $showSignIn) {
                    SignInView()
                }
        }
    }
}
