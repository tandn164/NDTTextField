//
//  NDTTextField.swift
//  NDTTextField
//
//  Created by Nguyễn Đức Tân on 05/06/2023.
//

import UIKit

public protocol NDTTextFieldProtocol: AnyObject {
    func setShadow(radius: CGFloat, opacity: Float, offset: CGSize, color: UIColor?)
    func setContentType(_ contentType: UITextContentType?)
    func setText(_ text: String)
    func setErrorMessage(_ error: String?)
    func setValidateFunc(_ validateFunc: ((String?)->Bool)?)
    func setValidateFuncWithErrorMessage(_ validateFunc: ((String?)->String?)?)
    func validateTextField()
    
    var isSecure: Bool { get }
    var secureImage: UIImage? { get }
    var insecureImage: UIImage? { get }
    var placeHolder: String? { get }
}

@IBDesignable
public class NDTTextField: UIView {
    
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var textField: CommonTextField!
    @IBOutlet weak var fieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isRequiredLabel: UILabel!
    @IBOutlet weak var secureIconView: UIView!
    @IBOutlet weak var secureImageView: UIImageView!
    @IBOutlet weak var errorLabel: CommonLabel!
    
    @IBInspectable public var isSecure: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecure
            secureIconView.isHidden = !isSecure
        }
    }
    @IBInspectable public var isRequire: Bool = false {
        didSet {
            isRequiredLabel.isHidden = !isRequire
        }
    }
    @IBInspectable public var secureImage: UIImage? {
        didSet {
            secureImageView.image = secureImage
        }
    }
    @IBInspectable public var insecureImage: UIImage?
    @IBInspectable public var borderColor: UIColor? {
        didSet {
            textFieldView.layer.borderColor = borderColor?.cgColor ?? UIColor.clear.cgColor
        }
    }
    @IBInspectable public var errorBorderColor: UIColor?
    @IBInspectable public var fieldTag: Int = 0 {
        didSet {
            textField.tag = fieldTag
        }
    }
    @IBInspectable public var titleFontName: String = "" {
        didSet {
            if titleFontName.isEmpty {
                titleLabel.font = UIFont.systemFont(ofSize: titleFontSize)
            } else {
                titleLabel.font = UIFont.init(name: titleFontName, size: titleFontSize)
            }
        }
    }
    @IBInspectable public var titleFontSize: CGFloat = 13 {
        didSet {
            if titleFontName.isEmpty {
                titleLabel.font = UIFont.systemFont(ofSize: titleFontSize)
            } else {
                titleLabel.font = UIFont.init(name: titleFontName, size: titleFontSize)
            }
        }
    }
    @IBInspectable public var title: String? {
        didSet {
            setupTitle()
        }
    }
    @IBInspectable public var fontName: String = "" {
        didSet {
            if fontName.isEmpty {
                textField.font = UIFont.systemFont(ofSize: fontSize)
            } else {
                textField.font = UIFont.init(name: fontName, size: fontSize)
            }
        }
    }
    @IBInspectable public var fontSize: CGFloat = 13 {
        didSet {
            if fontName.isEmpty {
                textField.font = UIFont.systemFont(ofSize: fontSize)
            } else {
                textField.font = UIFont.init(name: fontName, size: fontSize)
            }
        }
    }
    @IBInspectable public var errorFontName: String = "" {
        didSet {
            if errorFontName.isEmpty {
                errorLabel.font = UIFont.systemFont(ofSize: errorFontSize)
            } else {
                errorLabel.font = UIFont.init(name: errorFontName, size: errorFontSize)
            }
        }
    }
    @IBInspectable public var errorFontSize: CGFloat = 13 {
        didSet {
            if errorFontName.isEmpty {
                errorLabel.font = UIFont.systemFont(ofSize: errorFontSize)
            } else {
                errorLabel.font = UIFont.init(name: errorFontName, size: errorFontSize)
            }
        }
    }

    weak public var delegate: NDTFieldDelegate?

    var validateFunc: ((String?) -> Bool)?
    var validateFuncWithErrorMessage: ((String?) -> String?)?
    
    deinit {
        validateFunc = nil
        validateFuncWithErrorMessage = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let bundle = Bundle(for: type(of: self))
        let nib: UINib
        nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        view.frame = self.bounds
        
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.smartDashesType = .no
        textField.smartQuotesType = .no
        textField.smartInsertDeleteType = .no
        isRequiredLabel.isHidden = true
        secureIconView.isHidden = true
        errorLabel.isHidden = true
        fieldHeightConstraint.constant = 40
        textField.clearsOnBeginEditing = false
        titleView.isHidden = false
        setupTitle()
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    @IBAction func toggleSecureTextAction(_ sender: UIButton) {
        textField.isSecureTextEntry.toggle()
        secureImageView.image = textField.isSecureTextEntry ? secureImage : insecureImage
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.onEditing(fieldTag, textField.text)
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.onEndEditing(fieldTag, textField.text)
    }
    
    func setupTitle() {
        if let title = self.title {
            titleLabel.text = title
            titleView.isHidden = false
        } else {
            titleView.isHidden = true
        }
    }
}

extension NDTTextField: NDTFieldProtocol, NDTTextFieldProtocol {
    public func setShadow(radius: CGFloat, opacity: Float, offset: CGSize, color: UIColor?) {
        textFieldView.layer.masksToBounds = false
        textFieldView.layer.shadowRadius = radius
        textFieldView.layer.shadowOpacity = opacity
        textFieldView.layer.shadowOffset = offset
        textFieldView.layer.shadowColor = color?.cgColor
    }
    
    public func setContentType(_ contentType: UITextContentType?) {
        textField.textContentType = contentType
    }

    public func setText(_ text: String) {
        textField.text = text
    }
    
    public func setErrorMessage(_ error: String?) {
        if let error = error {
            errorLabel.text = error
            errorLabel.isHidden = false
            textFieldView.layer.borderColor = errorBorderColor?.cgColor
        } else {
            errorLabel.isHidden = true
            textFieldView.layer.borderColor = borderColor?.cgColor
        }
    }
    
    public func setValidateFunc(_ validateFunc: ((String?) -> Bool)?) {
        self.validateFunc = validateFunc
    }
    
    public func setValidateFuncWithErrorMessage(_ validateFunc: ((String?) -> String?)?) {
        self.validateFuncWithErrorMessage = validateFunc
    }
    
    public func validateTextField() {
        if let validateFuncWithErrorMessage = validateFuncWithErrorMessage {
            setErrorMessage(validateFuncWithErrorMessage(self.textField.text))
        } else {
            errorLabel.isHidden = true
            if validateFunc?(self.textField.text) ?? true {
                textFieldView.layer.borderColor = borderColor?.cgColor
            } else {
                textFieldView.layer.borderColor = errorBorderColor?.cgColor
            }
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return textFieldView.layer.cornerRadius
        }
        set {
            textFieldView.layer.cornerRadius = newValue
            textFieldView.layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return textFieldView.layer.borderWidth
        }
        set {
            textFieldView.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var fieldHeight: CGFloat {
        get {
            return fieldHeightConstraint.constant
        }
        set {
            fieldHeightConstraint.constant = newValue
        }
    }
    
    @IBInspectable public var placeHolder: String? {
        get {
            return textField.placeholder
        }
        set {
            textField.placeholder = newValue
        }
    }
    
    @IBInspectable public var textColor: UIColor? {
        get {
            return textField.textColor
        }
        set {
            textField.textColor = newValue
        }
    }
    
    @IBInspectable public var errorTextColor: UIColor? {
        get {
            return errorLabel.textColor
        }
        set {
            errorLabel.textColor = newValue
        }
    }
    
    @IBInspectable public var fieldTintColor: UIColor? {
        get {
            return textField.tintColor
        }
        set {
            textField.tintColor = newValue
        }
    }
    
    @IBInspectable public var titleColor: UIColor? {
        get {
            return titleLabel.textColor
        }
        set {
            titleLabel.textColor = newValue
        }
    }
}
