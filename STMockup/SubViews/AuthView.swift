//
//  AuthView.swift
//  STMockup
//
//  Created by alfeng on 10/10/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AuthView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack {
            Text("Sign in")
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button {
                register()
            } label : {
                Text("Sign up")
            }
            Button {
                login()
            } label: {
                Text("Already a user? Login")
            }
        }
        .padding()
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) {result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

#Preview {
    AuthView()
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
