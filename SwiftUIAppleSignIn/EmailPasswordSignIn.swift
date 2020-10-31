//
//  EmailPasswordSignIn.swift
//  SwiftUIAppleSignIn
//
//  Created by Michael Macatangay on 10/31/20.
//  Copyright © 2020 Michael Macatangay. All rights reserved.
//

import SwiftUI

struct EmailPasswordSignIn: View {
  @State var email: String = ""
  @State var password: String = ""
  @State var showAlert = false
  @State var alertText: String = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .disableAutocorrection(true)

            SecureField("Password", text: $password)
                .textContentType(.password)

            Button(action: signInTapped) {
                Text("Sign In")
                    .foregroundColor(Color.black)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertText))
            }
        }
        .padding()
    }

    private func signInTapped() {
        //TODO: remove white spaces and add further validation if needed
        
        guard !(email.isEmpty || password.isEmpty) else {
            self.alertText = "Please enter an email and password."
            self.showAlert = true
            return
        }
    
        //TODO: create separate class to process API request
        self.alertText = "Unable to process request at this time"
        self.showAlert = true
    }
}


struct EmailPasswordSignIn_Previews: PreviewProvider {
    static var previews: some View {
        EmailPasswordSignIn()
    }
}


