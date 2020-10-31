//
//  AppleSignIn.swift
//  SwiftUIAppleSignIn
//
//  Created by Michael Macatangay on 10/31/20.
//  Copyright © 2020 Michael Macatangay. All rights reserved.
//

import SwiftUI
import AuthenticationServices

final class AppleSignIn: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton()
    }
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}
