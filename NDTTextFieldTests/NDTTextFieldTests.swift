//
//  NDTTextFieldTests.swift
//  NDTTextFieldTests
//
//  Created by Nguyễn Đức Tân on 05/06/2023.
//

import XCTest
@testable import NDTTextField

final class NDTTextFieldTests: XCTestCase {
    let field = NDTTextField()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCommonInit() throws {
        XCTAssertNoThrow(field.commonInit())
    }
    
    func testToggleSecureTextAction() throws {
        field.textField.isSecureTextEntry = true
        field.toggleSecureTextAction(UIButton())
        XCTAssertEqual(field.textField.isSecureTextEntry, false)
    }
    
    func testSetText() throws {
        field.setText("test")
        XCTAssertEqual(field.textField.text, "test")
    }
    
    func testTextFieldDidChange() throws {
        XCTAssertNoThrow(field.textFieldDidChange(field.textField))
    }
    
    func testTextFieldDidEndEditing() throws {
        XCTAssertNoThrow(field.textFieldDidEndEditing(field.textField))
    }
    
    func testSetupTitle() throws {
        field.title = "test"
        field.setupTitle()
        XCTAssertFalse(field.titleView.isHidden, "\(field.titleView.isHidden)")
        field.title = nil
        XCTAssertTrue(field.titleView.isHidden, "\(field.titleView.isHidden)")
    }
    
    func testSetShadow() throws {
        field.setShadow(radius: 0.1, opacity: 0.1, offset: CGSize(width: 3, height: 3), color: .black)
        XCTAssertEqual(field.textFieldView.layer.masksToBounds, false)
        XCTAssertEqual(field.textFieldView.layer.shadowRadius, 0.1)
        XCTAssertEqual(field.textFieldView.layer.shadowOpacity, 0.1)
        XCTAssertEqual(field.textFieldView.layer.shadowOffset, CGSize(width: 3, height: 3))
        XCTAssertEqual(field.textFieldView.layer.shadowColor, UIColor.black.cgColor)
    }
    
    func testSetContentType() throws {
        field.setContentType(.emailAddress)
        XCTAssertEqual(field.textField.textContentType, .emailAddress)
    }
    
    func testSetErrorMessage() throws {
        field.setErrorMessage("Error")
        XCTAssertEqual(field.errorLabel.isHidden, false)
        field.setErrorMessage(nil)
        XCTAssertEqual(field.errorLabel.isHidden, true)
    }
    
    func testSetValidateFunc() throws {
        field.setValidateFunc { _ in
            return true
        }
        XCTAssertTrue(field.validateFunc?(field.textField.text) ?? false)
    }
    
    func testSetValidateFuncWithErrorMessage() throws {
        field.setValidateFuncWithErrorMessage { _ in
            return "test"
        }
        XCTAssertEqual(field.validateFuncWithErrorMessage?(field.textField.text) ?? nil, "test")
    }
    
    func testValidateTextField() throws {
        field.errorBorderColor = .red
        field.borderColor = .black
        
        field.setValidateFuncWithErrorMessage(nil)
        field.setValidateFuncWithErrorMessage(nil)
        field.validateTextField()
        XCTAssertEqual(field.textFieldView.layer.borderColor, UIColor.black.cgColor)
        
        field.setValidateFunc { _ in
            return false
        }
        field.validateTextField()
        XCTAssertEqual(field.textFieldView.layer.borderColor, UIColor.red.cgColor)

        field.setValidateFunc { _ in
            return true
        }
        field.validateTextField()
        XCTAssertEqual(field.textFieldView.layer.borderColor, UIColor.black.cgColor)
        
        field.setValidateFunc(nil)
        field.setValidateFuncWithErrorMessage { _ in
            return "test"
        }
        field.validateTextField()
        XCTAssertEqual(field.textFieldView.layer.borderColor, UIColor.red.cgColor)
        
        field.setValidateFuncWithErrorMessage { _ in
            return nil
        }
        field.validateTextField()
        XCTAssertEqual(field.textFieldView.layer.borderColor, UIColor.black.cgColor)
    }
    
    func testCornerRadius() throws {
        field.cornerRadius = 10
        
        XCTAssertEqual(field.cornerRadius, 10)
        XCTAssertEqual(field.textFieldView.layer.cornerRadius, 10)
    }
    
    func testBorderWidth() throws {
        field.borderWidth = 1
        
        XCTAssertEqual(field.borderWidth, 1)
        XCTAssertEqual(field.textFieldView.layer.borderWidth, 1)
    }
    
    func testFieldHeight() throws {
        field.fieldHeight = 44
        
        XCTAssertEqual(field.fieldHeight, 44)
        XCTAssertEqual(field.fieldHeightConstraint.constant, 44)
    }
    
    func testPlaceHolder() throws {
        field.placeHolder = "Test"
        
        XCTAssertEqual(field.placeHolder, "Test")
        XCTAssertEqual(field.textField.placeholder, "Test")
    }
    
    func testTextColor() throws {
        field.textColor = .red
        
        XCTAssertEqual(field.textColor, UIColor.red)
        XCTAssertEqual(field.textField.textColor, UIColor.red)
    }
    
    func testErrorTextColor() throws {
        field.errorTextColor = .red
        
        XCTAssertEqual(field.errorTextColor, UIColor.red)
        XCTAssertEqual(field.errorLabel.textColor, UIColor.red)
    }
    
    func testFieldTintColor() throws {
        field.fieldTintColor = .red
        
        XCTAssertEqual(field.fieldTintColor, UIColor.red)
        XCTAssertEqual(field.textField.tintColor, UIColor.red)
    }
    
    func testTitleFontName() throws {
        field.titleFontName = "HiraKakuProN-W6"
        
        XCTAssertEqual(field.titleFontName, "HiraKakuProN-W6")
        XCTAssertEqual(field.titleLabel.font?.fontName, "HiraKakuProN-W6")
        
        field.titleFontName = ""
        XCTAssertEqual(field.titleLabel.font, UIFont.systemFont(ofSize: field.titleFontSize))
    }
    
    func testTitleFontSize() throws {
        field.titleFontName = "HiraKakuProN-W6"
        field.titleFontSize = 14
        
        XCTAssertEqual(field.titleFontSize, 14)
        XCTAssertEqual(field.titleLabel.font?.pointSize, 14)
        
        field.titleFontName = ""
        field.titleFontSize = 13
        XCTAssertEqual(field.titleLabel.font, UIFont.systemFont(ofSize: field.titleFontSize))
    }
    
    func testTitle() throws {
        field.title = "Test"
        
        XCTAssertEqual(field.title, "Test")
        XCTAssertEqual(field.titleLabel.text, "Test")
    }
    
    func testFontName() throws {
        field.fontName = "HiraKakuProN-W6"
        
        XCTAssertEqual(field.fontName, "HiraKakuProN-W6")
        XCTAssertEqual(field.textField.font?.fontName, "HiraKakuProN-W6")
        
        field.fontName = ""
        XCTAssertEqual(field.textField.font, UIFont.systemFont(ofSize: field.fontSize))
    }
    
    func testFontSize() throws {
        field.fontName = "HiraKakuProN-W6"
        field.fontSize = 14
        
        XCTAssertEqual(field.fontSize, 14)
        XCTAssertEqual(field.textField.font?.pointSize, 14)
        
        field.fontName = ""
        field.fontSize = 13
        XCTAssertEqual(field.textField.font, UIFont.systemFont(ofSize: field.fontSize))
    }
    
    func testErrorFontName() throws {
        field.errorFontName = "HiraKakuProN-W6"
        
        XCTAssertEqual(field.errorFontName, "HiraKakuProN-W6")
        XCTAssertEqual(field.errorLabel.font?.fontName, "HiraKakuProN-W6")
        
        field.errorFontName = ""
        XCTAssertEqual(field.errorLabel.font, UIFont.systemFont(ofSize: field.errorFontSize))
    }
    
    func testErrorFontSize() throws {
        field.errorFontName = "HiraKakuProN-W6"
        field.errorFontSize = 14
        
        XCTAssertEqual(field.errorFontSize, 14)
        XCTAssertEqual(field.errorLabel.font?.pointSize, 14)
        
        field.errorFontName = ""
        field.errorFontSize = 13
        XCTAssertEqual(field.errorLabel.font, UIFont.systemFont(ofSize: field.errorFontSize))
    }
    
    func testIsSecure() throws {
        field.secureImage = UIImage()
        field.insecureImage = UIImage()
        field.isSecure = true
        XCTAssertFalse(field.secureIconView.isHidden)
    }
    
    func testIsRequire() throws {
        field.isRequire = true
        
        XCTAssertFalse(field.isRequiredLabel.isHidden)
    }
    
    func testFieldTag() throws {
        field.fieldTag = 1000
        
        XCTAssertEqual(field.textField.tag, 1000)
    }
    
    func testInit() throws {
        XCTAssertNoThrow(NDTTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0)))
        let archiver =  NSKeyedUnarchiver(forReadingWith: Data())
        let field2 = NDTTextField(coder: archiver)
        XCTAssertNotNil(field2)
    }
    
    func testBorderColor() throws {
        field.borderColor = .blue
        
        XCTAssertEqual(field.borderColor, .blue)
        XCTAssertEqual(field.textFieldView.layer.borderColor, UIColor.blue.cgColor)
        
        field.borderColor = nil
        XCTAssertNil(field.borderColor)
        XCTAssertEqual(field.textFieldView.layer.borderColor, UIColor.clear.cgColor)
    }
    
    func testCommonTextField() throws {
        let window = UIWindow()
        let textField = CommonTextField()
        
        window.addSubview(textField)
        textField.text = "test"
        textField.isSecureTextEntry = true
        
        XCTAssertTrue(textField.becomeFirstResponder())
        
        textField.isSecureTextEntry = false
        XCTAssertTrue(textField.becomeFirstResponder())
    }
    
    func testCommonLabel() throws {
        let window = UIWindow()
        let label = CommonLabel()
        window.addSubview(label)
        XCTAssertEqual(label.intrinsicContentSize.height, 6)
        label.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        label.text = "Testgyjklm"
        XCTAssertEqual(label.intrinsicContentSize.height, 12)
        XCTAssertNoThrow(label.drawText(in: CGRect(x: 0, y: 0, width: 0, height: 0)))
        XCTAssertEqual(label.sizeThatFits(CGSize(width: 10, height: 20)).height, 16)
    }
    
    func testTitleColor() throws {
        field.titleColor = .blue
        
        XCTAssertEqual(field.titleColor, .blue)
        XCTAssertEqual(field.titleLabel.textColor, UIColor.blue)
    }
}
