//
//  ViewController.swift
//  NDTTextFieldExample
//
//  Created by Nguyễn Đức Tân on 05/06/2023.
//

import UIKit
import NDTTextField

class ViewController: UIViewController {
    @IBOutlet weak var singleTextField: NDTTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleTextField.delegate = self
        singleTextField.setValidateFuncWithErrorMessage { text in
            guard let text = text, !text.isEmpty else {
                return nil
            }
            let emailRegex = "^[\\w.!#$%&'*+/=?^_`{|}~-]+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$"
            let pred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            return pred.evaluate(with: text) ? nil : "Invalid email"
        }
        
        let groupField = NDTTextFieldsGroup()
        (groupField.fieldByTag(0) as? NDTTextField)?.fieldTag = 0
    }
}

extension ViewController: NDTFieldDelegate {
    func onEditing(_ tag: Int, _ value: String?) {
        singleTextField.validateTextField()
    }
    
    func onEndEditing(_ tag: Int, _ value: String?) {
    }
}
