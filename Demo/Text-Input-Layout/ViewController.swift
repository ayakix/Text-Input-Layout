//
//  ViewController.swift
//  Text-Input-Layout
//
//  Created by r_ayaki on 2017/03/29.
//  Copyright © 2017年 ayakix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet fileprivate weak var emailTextInputView: TextInputView!
    @IBOutlet fileprivate var textInputViews: [TextInputView]!
    @IBOutlet fileprivate weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextInputView.validationType = .email
        emailTextInputView.textField.keyboardType = .emailAddress
        emailTextInputView.textField.returnKeyType = .done
    }
    
    @IBAction private func onValidationButtonClick(_ sender: UIButton) {
        let areValidated = !textInputViews.map({ $0.isValidated }).contains(false)
        resultLabel.text = areValidated ? "Validated :)" : "Invalidated :("
    }
}
