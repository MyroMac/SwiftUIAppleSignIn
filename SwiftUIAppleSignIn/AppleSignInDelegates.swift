//
//  AppleSignInDelegates.swift
//  SwiftUIAppleSignIn
//
//  Created by Michael Macatangay on 10/31/20.
//  Copyright © 2020 Michael Macatangay. All rights reserved.
//

import UIKit
import AuthenticationServices
import Contacts

class AppleSignInDelegates: NSObject {
    private let signInSucceeded: (Bool) -> Void
    private weak var window: UIWindow!
  
    init(window: UIWindow?, onSignedIn: @escaping (Bool) -> Void) {
        self.window = window
        self.signInSucceeded = onSignedIn
    }
}

extension AppleSignInDelegates: ASAuthorizationControllerDelegate {
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential) {
        guard let email = credential.email else {
            //TODO: handle case where we are not provided with the user email since user has already
            //clicked "Sign In With Apple" before. In this scenario, we will use
            //the credentials that Apple supplies us to match with a user stored in our database
            self.signInSucceeded(true)
            return
        }
        
        let userData = UserData(email: email, identifier: credential.user)
        //Storing data in keychain is critical. In the case that our register request to API fails, we will be able to access
        //user data again in the keychain but not from SignInWithApple feature.
        self.saveUserDataInKeychain(userData)
        self.registerNewAccountViaAPI(userData)
    }
    
    private func saveUserDataInKeychain(_ userData: UserData) {
        let keychain = KeychainSwift()
        keychain.set(userData.email, forKey: "email")
        keychain.set(userData.identifier, forKey: "userIdentifier")
    }
    
    private func registerNewAccountViaAPI(_ userData: UserData) {
        //TODO: create separate class to process API request
        self.signInSucceeded(true)
    }
  
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            //TODO: handle case where we are not provided with the user email since user has already
            //clicked "Sign In With Apple" before. In this scenario, we will use
            //the credentials that Apple supplies us to match with a user stored in our database
            self.registerNewAccount(credential: appleIdCredential)
            break
      
        case let _ as ASPasswordCredential:
            //TODO: create separate class to process API request to login user with User Identifier and Password
            self.signInSucceeded(true)
            break
      
        default:
            break
        }
    }
  
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.signInSucceeded(false)
    }
}

extension AppleSignInDelegates: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.window
    }
}
