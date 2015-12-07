//
//  LoginViewController.swift
//  sumoEGGs
//
//  Created by Fabian Kola on 03.12.15.
//  Copyright © 2015 Fabian Kola. All rights reserved.

import UIKit

class MainViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        if (PFUser.currentUser() == nil) {
            let loginViewController = PFLogInViewController()
            loginViewController.delegate = self
            loginViewController.fields = [.UsernameAndPassword, .LogInButton, .PasswordForgotten, .SignUpButton, .Facebook, .Twitter]
            loginViewController.emailAsUsername = true
            loginViewController.signUpController?.delegate = self
            self.presentViewController(loginViewController, animated: false, completion: nil)
            
            // 3. Anpassung vom loginViewController
            loginViewController.logInView?.dismissButton?.hidden = true
            let logoImage = UIImageView()
            logoImage.image = UIImage(named: "SUMO-EGG")
            logoImage.contentMode = UIViewContentMode.ScaleAspectFit
            loginViewController.logInView?.logo = logoImage
            
            // 4. Deklaration vom signupViewController
            let signupViewController = loginViewController.signUpController
            
            // 5. Anpassung vom loginViewController
            let logoImage2 = UIImageView()
            logoImage2.image = UIImage(named: "SUMO-EGG")
            logoImage2.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            signupViewController?.signUpView?.logo?.contentMode = UIViewContentMode.ScaleAspectFit
            signupViewController?.signUpView?.logo = logoImage2
            
        } else {
            presentLoggedInAlert()
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        presentLoggedInAlert()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        presentLoggedInAlert()
    }
    
    func presentLoggedInAlert() {
        let alertController = UIAlertController(title: "You're logged in", message: "Welcome to sumoEGGs", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}