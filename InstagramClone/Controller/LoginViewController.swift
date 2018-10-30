//
//  LoginViewController.swift
//  Instagram
//
//  Created by Vichet Meng on 10/28/18.
//  Copyright © 2018 Vichet Meng. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        print("signIn button pressed")
        PFUser.logInWithUsername(inBackground: userNameTextField.text!, password: passwordTextField.text!) { (user:PFUser?, error:Error?) in
            if user != nil {
                print("You're logged in")
                self.performSegue(withIdentifier: "LoginToWelcome", sender: self)
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = userNameTextField.text!
        user.password = passwordTextField.text!
        user.signUpInBackground { (success, error) in
            if success {
                print("Successfully created a user")
                self.performSegue(withIdentifier: "LoginToWelcome", sender: self)
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
