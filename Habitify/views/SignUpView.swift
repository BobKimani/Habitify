import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var localError: String?

    var body: some View {
        VStack(spacing: 35) {
            Spacer()

            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Full Name", text: $fullName)
                .textFieldStyle(.roundedBorder)

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)

            if let error = localError ?? authViewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding(.top, -15)
            }

            Button(action: {
                if password != confirmPassword {
                    localError = "Passwords do not match."
                } else {
                    localError = nil
                    authViewModel.signUp(email: email, password: password)
                }
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
