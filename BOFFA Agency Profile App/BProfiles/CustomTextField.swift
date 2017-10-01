//
//  CustomTextField.swift
//  BProfiles
//
//  Created by Louis-Philip Shahim on 2016/06/28.
//  Copyright © 2016 Louis-Philip Shahim. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    @IBInspectable var inset: CGFloat = 0
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setupView()
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
}
