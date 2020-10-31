//
//  ContentView.swift
//  SwiftUIAppleSignIn
//
//  Created by Michael Macatangay on 10/31/20.
//  Copyright © 2020 Michael Macatangay. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
@State var appleSignInDelegates: AppleSignInDelegates! = nil
@State var showAlert = false
@State var alertText: String = ""
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack {
                Image("BlackMamba")
                    .resizable()
                    .frame(width: 240.0, height: 240.0, alignment: .top)
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0,
                         maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity
                )
                EmailPasswordSignIn()

                AppleSignIn()
                    .frame(width: 280,
                          height: 60,
                       alignment: .bottom)
                    .onTapGesture(perform: showAppleLogin)
                    .frame(minWidth: 0,
                         maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .bottom
                    )
                
                Spacer()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertText))
                }
            } .frame(minWidth: 0,
                     maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity
            )
            
        }
    }

    private func showAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email]

        performSignIn(using: [request])
    }

    private func performSignIn(using requests: [ASAuthorizationRequest]) {
        //TODO: fix warning for iOS13
        appleSignInDelegates = AppleSignInDelegates(window: UIApplication.shared.keyWindow) { success in
        if success {
            self.alertText = "Login Successful. Mamba Forever."
            self.showAlert = true
        } else {
            self.alertText = "Login Failed. Mamba Out."
            self.showAlert = true
            }
        }

        let controller = ASAuthorizationController(authorizationRequests: requests)
        controller.delegate = appleSignInDelegates
        controller.presentationContextProvider = appleSignInDelegates

        controller.performRequests()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
