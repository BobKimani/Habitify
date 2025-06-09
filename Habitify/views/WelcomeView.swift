// Views/Splash/WelcomeView.swift
import SwiftUI

struct WelcomeView: View {
    @Binding var isActive: Bool

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image("logo") 
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)

            Text("Habitify")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Build better habits, one day at a time.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            Button(action: {
                withAnimation {
                    isActive = true
                }
            }) {
                Text("Get Started")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .padding(.bottom, 40)
        }
        .padding()
    }
}

#Preview {
    StatefulPreviewWrapper(false) { isActive in
        WelcomeView(isActive: isActive)
    }
}

