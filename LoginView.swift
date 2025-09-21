import SwiftUI

struct LoginView: View {

    @State private var isLoginMode = true

    @EnvironmentObject var viewModel: AuthViewModel

    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 16) {
         
            Text(isLoginMode ? "Welcome Back" : "Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(isLoginMode ? "Let's get started by filling out the form below." : "Sign up to get started.")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.bottom, 20)

            
            VStack(spacing: 15) {
            
                if !isLoginMode {
                    TextField("Username", text: $viewModel.username)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            
            if isLoginMode {
                Button("Forgot Password?") {
                    Task {
                       await forgotPassword()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                .font(.footnote)
                .foregroundColor(.blue)
            }

     
            Button(action: {
                Task {
                    if isLoginMode {
                        await signIn()
                    } else {
                        await signUp()
                    }
                }
            }) {
                Text(isLoginMode ? "Sign In" : "Sign Up")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
           
            HStack {
                Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.3))
                Text("OR").foregroundColor(.secondary)
                Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.3))
            }
            .padding()

         
            Button(action: {
              
            }) {
                HStack {
                    Image("google_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Continue with Google")
                        .fontWeight(.semibold)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                .padding(.horizontal)
            }
            
            Spacer()
            
           
            Button(action: {
                isLoginMode.toggle()
            }) {
                HStack(spacing: 4) {
                    Text(isLoginMode ? "Don't have an account?" : "Already have an account?")
                        .foregroundColor(.secondary)
                    Text(isLoginMode ? "Sign Up here" : "Sign In")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    
    private func signIn() async {
        do {
            try await viewModel.signIn()
        } catch {
            alertTitle = "Sign In Failed"
            alertMessage = error.localizedDescription
            showAlert = true
        }
    }
    
    private func signUp() async {
        do {
            try await viewModel.signUp()
        } catch {
            alertTitle = "Sign Up Failed"
            alertMessage = error.localizedDescription
            showAlert = true
        }
    }
    
    private func forgotPassword() async {
        do {
            guard !viewModel.email.isEmpty else {
                alertTitle = "Missing Email"
                alertMessage = "Please enter your email to reset your password."
                showAlert = true
                return
            }
            try await viewModel.sendPasswordReset()
            alertTitle = "Password Reset"
            alertMessage = "A password reset link has been sent to your email."
            showAlert = true
        } catch {
            alertTitle = "Error"
            alertMessage = error.localizedDescription
            showAlert = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}

