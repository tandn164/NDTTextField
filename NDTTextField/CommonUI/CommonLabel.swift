//
//  CommonLabel.swift
//  NDTTextField
//
//  Created by Nguyễn Đức Tân on 05/06/2023.
//

import UIKit

class CommonLabel: UILabel {
    
    private var verticalGutter: CGFloat {
        return ceil(font.pointSize / 6.0)
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height += verticalGutter * 2
        return size
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: verticalGutter,
                                                       left: 0.0,
                                                       bottom: verticalGutter,
                                                       right: 0.0)))
    }
    
    override var alignmentRectInsets: UIEdgeInsets {
        let alignmentRectInsets = super.alignmentRectInsets
        return UIEdgeInsets(top: alignmentRectInsets.top + verticalGutter,
                            left: alignmentRectInsets.left,
                            bottom: alignmentRectInsets.bottom + verticalGutter,
                            right: alignmentRectInsets.right)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height += verticalGutter * 2
        return size
    }
}
