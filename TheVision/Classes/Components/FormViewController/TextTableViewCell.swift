//
//  TextTableViewCell.swift
//  Vision
//
//  Created by Sergio Daniel L. García on 6/7/18.
//  Copyright © 2018 Sergio Lozano García. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Stored properties
    
    var field: XVSField?
    
    var theme = XVSFormTheme.light
    
    weak var delegate: FieldCellDelegate?

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        handleTheme()
        
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Operations
    
    func configAsName(forField field: XVSField) {
        textField.autocapitalizationType = .words
        
        configChangeTracking()
        handleClearButtonMode(fromOptions: field.options)
        handlePlaceholder(forField: field)
        
        handleTheme()
        
        self.field = field
    }
    
    func configAsEmail(forField field: XVSField) {
        textField.keyboardType = .emailAddress
        
        configChangeTracking()
        handleClearButtonMode(fromOptions: field.options)
        handlePlaceholder(forField: field)
        
        handleTheme()
        
        self.field = field
    }
    
    func configAsPassword(forField field: XVSField) {
        textField.isSecureTextEntry = true
        
        configChangeTracking()
        handleClearButtonMode(fromOptions: field.options)
        handlePlaceholder(forField: field)
        
        handleTheme()
        
        self.field = field
    }
    
    func configAsText(forField field: XVSField) {
        configChangeTracking()
        handleClearButtonMode(fromOptions: field.options)
        handlePlaceholder(forField: field)
        
        handleTheme()
        
        self.field = field
    }
    
    func configAsPhoneNumber(forField field: XVSField) {
        textField.keyboardType = .namePhonePad
        
        configChangeTracking()
        handleClearButtonMode(fromOptions: field.options)
        handlePlaceholder(forField: field)
        
        handleTheme()
        
        self.field = field
    }
    
    // MARK: - Private operations
    
    private func configChangeTracking() {
        textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    private func handleClearButtonMode(fromOptions options: XVSFieldOptions?) {
        if let hasClearButton = options?[.hasClearButton] as? Bool {
            textField.clearButtonMode = hasClearButton ? .whileEditing : .never
        } else {
            textField.clearButtonMode = .whileEditing
        }
    }
    
    private func handlePlaceholder(forField field: XVSField) {
        if let placeholder = field.options?[.placeholder] as? String {
            if theme == .dark {
                textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
                    .foregroundColor : DarkTouchTweaker.Color.textFieldsPlaceholderForeground
                ])
            } else {
                textField.placeholder = placeholder
            }
        } else {
            if theme == .dark {
                textField.attributedPlaceholder = NSAttributedString(string: field.title, attributes: [
                    .foregroundColor : DarkTouchTweaker.Color.textFieldsPlaceholderForeground
                ])
            } else {
                textField.placeholder = field.title
            }
        }
    }
    
    private func handleTheme() {
        if theme == .dark {
            contentView.backgroundColor = DarkTouchTweaker.Color.textFieldsColor
            textField.backgroundColor = DarkTouchTweaker.Color.textFieldsColor
            textField.textColor = UIColor.lightText
            textField.keyboardAppearance = .dark
            
        }
    }
    
    // MARK: - Actions
    
    @objc func textFieldDidChange(textField: UITextField) {
        guard let field = field else {
            return
        }
        
        delegate?.cell(forField: field, changedToValue: textField.text)
    }

}

extension TextTableViewCell : FormFieldProtocol {
    
    var currentSavedValue: Any? {
        return textField.text
    }
    
}
