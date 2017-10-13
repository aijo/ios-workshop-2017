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
        logoConstraint.constant = view.center.y-(LOGO_HEIGHT/2)
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


}

