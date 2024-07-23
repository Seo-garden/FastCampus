//
//  ViewController.swift
//  KTV
//
//  Created by 서정원 on 7/22/24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.layer.cornerRadius = 19
        self.loginButton.layer.borderColor = UIColor(named: "main-brown")?.cgColor
        
        self.loginButton.layer.borderWidth = 1
    }

    @IBAction func buttonDidTap(_ sender: UIButton) {
        self.view.window?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBar")
    }
    
    
}

