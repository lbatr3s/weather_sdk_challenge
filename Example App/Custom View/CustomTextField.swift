//
//  CustomTextField.swift
//  Example App
//
//  Created by Lester Batres on 22/10/24.
//

import UIKit

final class CustomTextField: UITextField {

    private let padding: CGFloat = 16.0
    private let border1pt: CGFloat = 1.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    // MARK: Override methods
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let padding = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        return bounds.inset(by: padding)
    }
    
    private func updateEditingStyle(isEditing: Bool) {
        if isEditing {
            layer.borderColor = UIColor.accentHighlighted.cgColor
            layer.borderWidth = border1pt
        } else {
            layer.borderColor = UIColor.textBorder.cgColor
            layer.borderWidth = border1pt
        }
    }
    
    private func setupUI() {
        font = .textRegular
        textColor = .textPrimary
        layer.cornerRadius = 16.0
        clipsToBounds = true
        delegate = self
        updateEditingStyle(isEditing: false)
    }
}

// MARK: UITextField delegate methods

extension CustomTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateEditingStyle(isEditing: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateEditingStyle(isEditing: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
