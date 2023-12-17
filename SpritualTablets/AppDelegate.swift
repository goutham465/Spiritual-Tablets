//
//  AppDelegate.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 22/04/23.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleUtilities
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        appDelegate?.window = self.window
     //   GIDSignIn.sharedInstance.clientID = FirebaseApp.app()?.options.clientID // "187478475878-l8dbqjcp1p4j6eppm0t2iakobfdq4glp.apps.googleusercontent.com"
     //   GIDSignIn.sharedInstance.delegate = self
        let signInConfig = GIDConfiguration(clientID: "187478475878-l8dbqjcp1p4j6eppm0t2iakobfdq4glp.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
            } else {
                // Show the app's signed-in state.
            }
        }
      //  self.loginHomeVC()
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                break // The Apple ID credential is valid.
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                DispatchQueue.main.async {
                   // self.window?.rootViewController?.showLoginViewController()
                    self.loginHomeVC()
                }
            default:
                break
            }
        }
        return true
    }
    func loginHomeVC() {
        let loginBy = UserDefaults.standard.string(forKey: "login_by")
        if loginBy != nil && loginBy == "PHONE" || loginBy == "GOOGLE" || loginBy == "APPLE" {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC
            let navigationController = UINavigationController(rootViewController: rootViewController!)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let destinationController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
                let navigationController = UINavigationController(rootViewController: destinationController)
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
            }

        }
    }
//    func sign(_ signIn: GIDSignIn!,
//              didSignInFor user: GIDGoogleUser!,
//              withError error: Error!) {
//
//        // Check for sign in error
//        if let error = error {
//            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
//                print("The user has not signed in before or they have since signed out.")
//            } else {
//                print("\(error.localizedDescription)")
//            }
//            return
//        }
//
//        // Get credential object using Google ID token and Google access token
//        guard let authentication = user.authentication else {
//            return
//        }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//
//        // Authenticate with Firebase using the credential object
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//            if let error = error {
//                print("Error occurs when authenticate with Firebase: \(error.localizedDescription)")
//            }
//
//            // Post notification after user successfully sign in
//            NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
//        }
//
//    }
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        
        let loginBy = UserDefaults.standard.string(forKey: "login_by")
        if loginBy != nil && loginBy == "PHONE" {
            return Auth.auth().canHandle(url)
        } else {
            // Google Sign IN
            return GIDSignIn.sharedInstance.handle(url)
        }
        return true
    }
}

