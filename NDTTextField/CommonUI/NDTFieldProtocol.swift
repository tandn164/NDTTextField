//
//  NDTFieldProtocol.swift
//  NDTTextField
//
//  Created by Nguyễn Đức Tân on 08/06/2023.
//

import UIKit

public protocol NDTFieldProtocol: AnyObject {
    var delegate: NDTFieldDelegate? { get }
    var isRequire: Bool { get }
    var cornerRadius: CGFloat { get }
    var borderColor: UIColor? { get }
    var errorBorderColor: UIColor? { get }
    var borderWidth: CGFloat { get }
    var fieldHeight: CGFloat { get }
    var fieldTag: Int { get }
    var textColor: UIColor? { get }
    var errorTextColor: UIColor? { get }
    var fieldTintColor: UIColor? { get }
    var titleFontName: String { get }
    var titleFontSize: CGFloat { get }
    var title: String? { get }
    var fontName: String { get }
    var fontSize: CGFloat { get }
    var errorFontName: String { get }
    var errorFontSize: CGFloat { get }
    var titleColor: UIColor? { get }
}

public protocol NDTFieldDelegate: AnyObject {
    func onEditing(_ tag: Int, _ value: String?)
    func onEndEditing(_ tag: Int, _ value: String?)
}
