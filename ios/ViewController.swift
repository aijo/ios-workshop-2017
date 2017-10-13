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
    @IBOutlet weak var signinButton: UIButton!
    
    private let LOGO_DEFAULT_CONSTRAINT:CGFloat = 40
    private let LOGO_HEIGHT:CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        signinFormView.alpha = 0
        signinButton.layer.cornerRadius = 5
        signinButton.layer.masksToBounds = true
        logoConstraint.constant = view.center.y-(LOGO_HEIGHT/2)
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(dismissGesture)
        
        secretTextfield.delegate = self
        secretTextfield.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        signinButton.isEnabled = false
        signinButton.setBackgroundColor(color: UIColor.init(rgba: "#2EB0FC"), forState: .normal)
        signinButton.setBackgroundColor(color: UIColor.init(rgba: "#EEEEEE"), forState: .disabled)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logoConstraint.constant = LOGO_DEFAULT_CONSTRAINT
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 3.0, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0) {
            self.signinFormView.alpha = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension ViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let secret = secretTextfield.text {
            signinButton.isEnabled = secret.characters.count > 0
        }
    }
    
}
