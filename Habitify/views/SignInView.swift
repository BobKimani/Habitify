import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            Text("Welcome Back")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            if let error = authViewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }

            Button(action: {
                authViewModel.signIn(email: email, password: password)
            }) {
                Text("Sign In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Spacer()

            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                NavigationLink("Sign Up", destination: SignUpView())
                    .foregroundColor(.purple)
                    .fontWeight(.semibold)
            }
        }
        .padding()
    }
}

#Preview {
    SignInView()
        .environmentObject(AuthViewModel())
}
