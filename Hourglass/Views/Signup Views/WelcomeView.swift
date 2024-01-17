import SwiftUI

struct WelcomeView: View {
    @State private var name: String = ""
    @State private var password: String = ""
    var email: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
            VStack(alignment: .leading) {
                Text("Welcome to Asana!")
                    .font(.largeTitle)
                
                Text("You're signing up as \(email).")
                    .foregroundStyle(.secondary)
            }
            
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(64)
                    .background {
                        Circle()
                            .strokeBorder(
                                .secondary,
                                style: .init(
                                    lineWidth: 1,
                                    dash: [2]
                                )
                            )
                    }
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "camera")
                            .imageScale(.small)
                            .padding(12)
                            .background {
                                Circle()
                                    .fill(.background)
                                    .strokeBorder(.secondary)
                            }
                    }
                
                VStack(alignment: .leading) {
                    SwiftUI.Section {
                        TextField("Full name", text: $name)
                            .textFieldStyle(.roundedBorder)
                    } header: {
                        Text("What's your full name?")
                            .font(.title3)
                            .fontWeight(.medium)
                    } footer: {
                        Text("That looks like an email address. Please enter your full name.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.bottom)
                    }
                    
                    
                    SwiftUI.Section {
                        SecureField("Password", text: $password)
                            .textFieldStyle(.roundedBorder)
                    } header: {
                        Text("Password")
                            .font(.title3)
                            .fontWeight(.medium)
                    } footer: {
                        Text("Create a password with at least 8 characters.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            Button("Continue") {
                
            }
            .buttonStyle(.borderedProminent)
            .disabled(name.isEmpty || password.isEmpty)
        }
        .padding()
        .padding(.horizontal)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

#Preview {
    WelcomeView(email: "nblack@velomethod.com")
}
