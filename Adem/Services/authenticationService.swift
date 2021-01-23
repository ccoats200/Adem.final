//
//  authenticationService.swift
//  Adem
//
//  Created by Coleman Coats on 1/21/21.
//  Copyright © 2021 Coleman Coats. All rights reserved.
//

import Foundation
import Firebase
import Resolver

class AuthenticationService: ObservableObject {
  
  @Published var user: User? // (1)
  
  func signIn() {
    registerStateListener() // (2)
    firebaseAuth.signInAnonymously() // (3)
  }
  
  private func registerStateListener() {
    firebaseAuth.addStateDidChangeListener { (auth, user) in // (4)
      print("Sign in state has changed.")
      self.user = user
      
      if let user = user {
        let anonymous = user.isAnonymous ? "anonymously " : ""
        print("User signed in \(anonymous)with user ID \(user.uid).")
      }
      else {
        print("User signed out.")
      }
    }
  }
  
}

extension Resolver: ResolverRegistering {
  public static func registerAllServices() {
    register { AuthenticationService() }.scope(application)
    //register { FirestoreTaskRepository() as TaskRepository }.scope(application)
  }
}
