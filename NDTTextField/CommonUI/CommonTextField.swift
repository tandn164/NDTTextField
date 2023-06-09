//
//  CommonTextField.swift
//  NDTTextField
//
//  Created by Nguyễn Đức Tân on 05/06/2023.
//

import UIKit

class CommonTextField: UITextField {
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text, !text.isEmpty {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }
}
