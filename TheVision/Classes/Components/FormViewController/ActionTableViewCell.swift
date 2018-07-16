//
//  ActionTableViewCell.swift
//  Vision
//
//  Created by Sergio Daniel L. García on 6/8/18.
//  Copyright © 2018 Sergio Lozano García. All rights reserved.
//

import UIKit

class ActionTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var actionButton: UIButton!
    
    // MARK: - Stored properties
    
    var actionClosure: VSHandler?
    
    var theme = VSFormTheme.light
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupActionButton()
    }
    
    override func layoutSubviews() {
        handleTheme()
        
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private operations
    
    private func setupActionButton() {
        actionButton.layer.cornerRadius = 12.0
        actionButton.clipsToBounds = true
        actionButton.backgroundColor = tintColor
    }
    
    private func handleEnability(forField field: VSField) {
        guard let isEnabled = field.options?[.isEnabled] as? Bool else { return }
        actionButton.isEnabled = isEnabled
        
        if isEnabled {
            if field.type == .cta {
                actionButton.backgroundColor = actionButton.tintColor
            }
        } else {
            if field.type == .cta {
                actionButton.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    // MARK: - Operations
    
    func configAsCTA(forField field: VSField, withHandler handler: VSHandler?) {
        actionClosure = handler
        actionButton.setTitle(field.title, for: .normal)
        handleEnability(forField: field)
        handleTheme()
    }
    
    func configAsAction(forField field: VSField, withHandler handler: VSHandler?) {
        actionClosure = handler
        actionButton.setTitle(field.title, for: .normal)
        actionButton.backgroundColor = UIColor.clear
        actionButton.setTitleColor(actionButton.tintColor, for: .normal)
        handleEnability(forField: field)
        handleTheme()
    }
    
    func configAsDelete(forField field: VSField, withHandler handler: VSHandler?) {
        actionClosure = handler
        actionButton.setTitle(field.title, for: .normal)
        handleEnability(forField: field)
        handleTheme()
    }
    
    // MARK: - Private operations
    
    private func handleTheme() {
        if theme == .dark {
            contentView.backgroundColor = DarkTouchTweaker.Color.backgroundColor
        }
    }
    
    // MARK: - Actions
    
    @IBAction func userDidTapAction(_ sender: UIButton) {
        actionClosure?()
    }

}
