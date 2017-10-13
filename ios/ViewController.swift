//
//  ViewController.swift
//  ios
//
//  Created by JO10X on 10/13/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var signinFormView: UIView!
    @IBOutlet weak var secretTextfield: UITextField!
    @IBOutlet weak var secretStatusView: UIView!
    @IBOutlet weak var signinButton: UIButton!
    
    private let LOGO_DEFAULT_CONSTRAINT:CGFloat = 40
    private let LOGO_HEIGHT:CGFloat = 100
    private let LOGGED_IN:String = "LOGGED_IN"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        signinFormView.alpha = 0
        signinButton.layer.cornerRadius = 5
        signinButton.layer.masksToBounds = true
        logoConstraint.constant = view.center.y-(LOGO_HEIGHT/2)
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissGesture)
        
        secretTextfield.delegate = self
        secretTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        signinButton.isEnabled = false
        signinButton.setBackgroundColor(color: UIColor.init(rgba: "#2EB0FC"), forState: .normal)
        signinButton.setBackgroundColor(color: UIColor.init(rgba: "#EEEEEE"), forState: .disabled)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: LOGGED_IN) {
            loggedIn()
        } else {
            logoConstraint.constant = LOGO_DEFAULT_CONSTRAINT
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 3.0, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            UIView.animate(withDuration: 2.0) {
                self.signinFormView.alpha = 1
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signButtonDidPressed(_ sender: Any) {
        if let secret = secretTextfield.text {
            if secret == "secret" {
                secretStatusView.backgroundColor = UIColor.init(rgba: "#E2E2E2")
                loggedIn()
            } else {
                secretStatusView.backgroundColor = UIColor.init(rgba: "#AA3939")
                shakeView(shakeView: signinFormView)
            }
        }
    }
    
    fileprivate func loggedIn() {
        UserDefaults.standard.set(true, forKey: LOGGED_IN)
        self.performSegue(withIdentifier: "gotoMain", sender: nil)
    }
    
    fileprivate func shakeView(shakeView: UIView) {
        shakeView.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            shakeView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

@objc extension ViewController: UITextFieldDelegate {
    
    fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    fileprivate func textFieldDidChange(_ textField: UITextField) {
        if let secret = secretTextfield.text {
            signinButton.isEnabled = secret.characters.count > 0
        }
    }
    
}
