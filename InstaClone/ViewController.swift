//
//  ViewController.swift
//  InstaClone
//
//  Created by english on 2024-02-01.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailText:UITextField!
    @IBOutlet weak var passwordText:UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        emailText.text = "sandeep@test.com"
        passwordText.text = "123456"
        
//        checkLogin()
    }
    
    func checkLogin() {
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: Segue.toHomeScreen, sender: nil)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton){
        // check for the missing email or password
        if(emailText.text != "" && passwordText.text != ""){
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!){
                (auth, error) in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Some problem occured")
                }else{
                    self.makeAlert(title: "Success", message: "Logged in", onCompletion: {
                        () -> Void in
                        self.performSegue(withIdentifier: Segue.toHomeScreen, sender: nil)
                    })
                   
                }
            }
            
        }else{
            makeAlert(title: "missing", message: "yo not email or passwor")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toHomeScreen {
            if let destinationVC = segue.destination as? HomeViewController {
                destinationVC.navigationItem.hidesBackButton = true
            }
        }
    }
    
    func makeAlert(title: String, message: String, onCompletion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            onCompletion?()
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}

