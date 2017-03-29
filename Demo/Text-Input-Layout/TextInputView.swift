//
//  TextInputView.swift
//  roco
//
//  Created by r_ayaki on 2016/12/21.
//  Copyright © 2016年 Ayakix Inc. All rights reserved.
//

import UIKit

enum TextInputValidationType: Int {
    case none
    case email
}

@IBDesignable
class TextInputView: UIView {
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var titleViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var requiredLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet fileprivate weak var errorLabel: UILabel!
    
    @IBInspectable var title: String = "" {
        didSet {
            titleLabel?.text = title
            titleLabel?.sizeToFit()
            titleViewWidthConstraint?.constant = titleLabel.frame.width
        }
    }
    @IBInspectable var isRequired: Bool = true {
        didSet {
            requiredLabel?.isHidden = !isRequired
        }
    }
    @IBInspectable var placeholder: String = "" {
        didSet {
            textField?.placeholder = placeholder
        }
    }
    @IBInspectable var errorMessage: String = "" {
        didSet {
            errorLabel?.text = errorMessage
        }
    }
    
    var validationType: TextInputValidationType = .none
    var text: String {
        return textField?.text ?? ""
    }
    var isValidated: Bool {
        errorLabel.isHidden = true
        switch validationType {
        case .email:
            errorLabel.isHidden = isEmail(text: text)
        default:
            break
        }
        
        if text.isEmpty {
            errorLabel.isHidden = !isRequired
        }
        
        return errorLabel.isHidden
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

fileprivate extension TextInputView {
    func commonInit() {
        if self.subviews.count != 0 {
            return
        }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TextInputView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func isEmail(text: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: text)
    }
}
