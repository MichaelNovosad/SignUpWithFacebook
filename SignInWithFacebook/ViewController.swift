//
//  ViewController.swift
//  SignInWithFacebook
//
//  Created by Michael Novosad on 22.03.2022.
//


// Add this to the header of your file, e.g. in ViewController.swift
import UIKit
import FBSDKLoginKit

// Add this to the body
class ViewController: UIViewController, LoginButtonDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = AccessToken.current, !token.isExpired {
            
        } else {
            
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
            view.addSubview(loginButton)
        }
    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(
            graphPath: "me",
            parameters: ["fields": "email, name"],
            tokenString: token,
            version: nil,
            httpMethod: .get)
        
        request.start { connection, result, error in
            print("\(result)")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logged out")
    }
    
}
