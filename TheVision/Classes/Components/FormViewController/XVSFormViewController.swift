//
//  FormViewController.swift
//  Vision
//
//  Created by Sergio Lozano García on 6/6/18.
//  Copyright © 2018 Sergio Lozano García. All rights reserved.
//

import UIKit

public protocol XVSFormViewControllerDelegate : class {
    
    func formView(_ viewController: XVSFormViewController, didAbortWithValues values: XVSFieldValues)
    func formView(_ viewController: XVSFormViewController, didCompleteWithValues values: XVSFieldValues)
    
    func formView(_ viewController: XVSFormViewController, shouldAllowToCompleteWithValues values: XVSFieldValues) -> Bool
    func formView(_ viewController: XVSFormViewController, shouldAllowToAbortWithValues values: XVSFieldValues) -> Bool
    
    func formView(_ viewController: XVSFormViewController, emmitedActionFromField field: XVSField, whileHavingValues values: XVSFieldValues)
    
}

public class XVSFormViewController: UITableViewController {
    
    // MARK: - Nested types
    
    private struct Constants {
        static let ctaActionName = "cta"
    }
    
    // MARK: - Class members
    
    // MARK: - Stored properties
    
    public var name = String()
    
    private var sections = [XVSSection]()
    
    private weak var delegate: XVSFormViewControllerDelegate?
    
    private var options: XVSFormOptions? {
        didSet {
            if delegate == nil {
                print("Warning: Delegate has not been set before setting options. This could result in unexpected behaviors.")
            }
            
            if let mode = options?[.mode] as? XVSFormMode,
                mode == .action {
                
                let actionCopy = options?[.actionCopy] as? String ?? "Done"
                
                var shouldActionBeInitiallyEnabled = true
                
                if let delegate = delegate {
                    shouldActionBeInitiallyEnabled = delegate.formView(self, shouldAllowToCompleteWithValues: currentValues)
                }
                
                let actionField = XVSField(name: Constants.ctaActionName, title: actionCopy, type: .cta, size: .medium, options: [
                    .isEnabled: shouldActionBeInitiallyEnabled
                ])
                
                let actionSection = XVSSection(title: "", fields: [actionField], collapsable: false)
                sections.append(actionSection)
                
                //print(sections)
            }
        }
    }
    
    // MARK: - Computed properties
    
    private var mode: XVSFormMode {
        return options?[.mode] as? XVSFormMode ?? .action
    }
    
    private var theme: XVSFormTheme {
        return options?[.theme] as? XVSFormTheme ?? .light
    }
    
    private var ctaField: XVSField? {
        let lastSection = sections.last
        let lastField = lastSection?.fields.last
        
        if let ctaField = lastField,
            ctaField.name == Constants.ctaActionName {
            return ctaField
        } else {
            return nil
        }
    }
    
    private var currentValues: XVSFieldValues {
        var values = [String: Any?]()
        
        var sectionIterator = 0
        
        for section in sections {
            var fieldIterator = 0
            
            for field in section.fields {
                let indexPath = IndexPath(row: fieldIterator, section: sectionIterator)
                
                if let cell = tableView.cellForRow(at: indexPath) as? FormFieldProtocol {
                    values[field.name] = cell.currentSavedValue
                }
                
                fieldIterator += 1
            }
            
            sectionIterator += 1
        }
        
        return values
    }
    
    // MARK: - Initializers
    
    public static func instantiate(withName name: String,
                                   fields: [XVSField],
                                   delegate: XVSFormViewControllerDelegate? = nil,
                                   options: XVSFormOptions? = nil) -> UIViewController {
        
        let sections = [
            XVSSection(title: String(), fields: fields, collapsable: false)
        ]
        
        return instantiate(withName: name,
                           sections: sections,
                           delegate: delegate,
                           options: options)
    }
    
    public static func instantiate(withName name: String,
                                   sections: [XVSSection],
                                   delegate: XVSFormViewControllerDelegate?,
                                   options: XVSFormOptions? = nil) -> UIViewController {
        
        let presentation = options?[.presentation] as? XVSFormPresentation
        
        let storyboard = UIStoryboard(name: K.Storyboard.FormViewController,
                                    bundle: Bundle(for: XVSFormViewController.self))
        let vc = storyboard.instantiateInitialViewController() as! XVSFormViewController
        
        vc.name = name
        vc.sections = sections
        vc.delegate = delegate // Delegate should always go before options
        vc.options = options
        
        print(vc.sections)
        
        if presentation == .modal {
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                  target: vc,
                                                                  action: #selector(userDidTapToAbort(sender:)))
            
            return UINavigationController(rootViewController: vc)
        } else {
            return vc
        }
    }
    
    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //tableView.separatorColor = UIColor.clear
        
        setupTheme()
        setupActions()
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private operations
    
    private func setupTheme() {
        if theme == .dark {
            DarkTouchTweaker.setDarkMode(viewController: self)
            tableView.separatorColor = DarkTouchTweaker.Color.separatorsColor
        }
    }
    
    private func setupActions() {
        switch mode {
        case .action:
            break
        case .new:
            break
        case .edit:
            break
        case .editDelete:
            break
        case .view:
            break
        }
    }
    
    private func updateCompletionAvailability() {
        guard let delegate = delegate,
            sections.count > 0 else {
            return
        }
        
        if mode == .action {
            let isEnabled = delegate.formView(self, shouldAllowToCompleteWithValues: currentValues)
            
            // Unsafe
            let lastSectionsIndex = sections.count - 1
            let lastFieldsIndex = sections.last!.fields.count - 1
            
            sections[lastSectionsIndex].fields[lastFieldsIndex].options?[.isEnabled] = isEnabled
            
            let indexPathToReload = IndexPath(row: lastFieldsIndex, section: lastSectionsIndex)
            tableView.reloadRows(at: [indexPathToReload], with: .none)
        } else {
            // Play with enability of bar item action
        }
    }

    // MARK: - Table view data source

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionItem = sections[section]
        return sectionItem.fields.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let field = section.fields[indexPath.row]
        
        switch field.type {
        case .name:
            let identifier = K.ReuseIdentifier.textViewCellReuseId
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath)
            
            //cell.separatorInset = UIEdgeInsetsMake(0.0, cell.bounds.size.width, 0.0, 0.0)
            
            if let textCell = cell as? TextTableViewCell {
                textCell.theme = theme
                textCell.configAsName(forField: field)
                textCell.delegate = self
            }
            
            return cell
        case .email:
            let identifier = K.ReuseIdentifier.textViewCellReuseId
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath)
            
            //cell.separatorInset = UIEdgeInsetsMake(0.0, cell.bounds.size.width, 0.0, 0.0)
            
            if let textCell = cell as? TextTableViewCell {
                textCell.theme = theme
                textCell.configAsEmail(forField: field)
                textCell.delegate = self
            }
            
            return cell
        case .password:
            let identifier = K.ReuseIdentifier.textViewCellReuseId
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath)
            
            //cell.separatorInset = UIEdgeInsetsMake(0.0, cell.bounds.size.width, 0.0, 0.0)
            
            if let textCell = cell as? TextTableViewCell {
                textCell.theme = theme
                textCell.configAsPassword(forField: field)
                textCell.delegate = self
            }
            
            return cell
        case .text:
            let identifier = K.ReuseIdentifier.textViewCellReuseId
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath)
            
            //cell.separatorInset = UIEdgeInsetsMake(0.0, cell.bounds.size.width, 0.0, 0.0)
            
            if let textCell = cell as? TextTableViewCell {
                textCell.theme = theme
                textCell.configAsText(forField: field)
                textCell.delegate = self
            }
            
            return cell
        case .phoneNumber:
            let identifier = K.ReuseIdentifier.textViewCellReuseId
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath)
            
            //cell.separatorInset = UIEdgeInsetsMake(0.0, cell.bounds.size.width, 0.0, 0.0)
            
            if let textCell = cell as? TextTableViewCell {
                textCell.theme = theme
                textCell.configAsPhoneNumber(forField: field)
                textCell.delegate = self
            }
            
            return cell
        case .cta:
            let identifier = K.ReuseIdentifier.actionViewCellReuseId
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath)
            
            if let actionCell = cell as? ActionTableViewCell {
                actionCell.theme = theme
                actionCell.configAsCTA(forField: field) { [unowned self] in
                    self.userDidTapToConfirm(sender: actionCell)
                }
            }
            
            return cell
        case .action:
            let identifier = K.ReuseIdentifier.actionViewCellReuseId
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath)
            
            if let actionCell = cell as? ActionTableViewCell {
                actionCell.theme = theme
                actionCell.configAsAction(forField: field) { [unowned self] in
                    self.delegate?.formView(self, emmitedActionFromField: field, whileHavingValues: self.currentValues)
                }
            }
            
            return cell
        case .deleteAction:
            let identifier = K.ReuseIdentifier.actionViewCellReuseId
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath)
            
            if let actionCell = cell as? ActionTableViewCell {
                actionCell.theme = theme
                actionCell.configAsDelete(forField: field) {
                    
                }
            }
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            return cell
        }
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        let field = section.fields[indexPath.row]
        
        switch field.size {
        case .regular:
            return 44.0
        case .medium:
            return 50.0
        case .big:
            return 56.0
        }
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Actions
    
    @objc func userDidTapToAbort(sender: UIBarButtonItem) {
        if let presentation = options?[.presentation] as? XVSFormPresentation,
            presentation == .modal {
            dismiss(animated: true) { [unowned self] in
                self.delegate?.formView(self, didAbortWithValues: self.currentValues)
            }
        } else {
            self.delegate?.formView(self, didAbortWithValues: self.currentValues)
        }
    }
    
    @objc func userDidTapToConfirm(sender: Any) {
        if let presentation = options?[.presentation] as? XVSFormPresentation,
            presentation == .modal {
            dismiss(animated: true) { [unowned self] in
                self.delegate?.formView(self, didCompleteWithValues: self.currentValues)
            }
        } else {
            navigationController?.popViewController(animated: true)
            self.delegate?.formView(self, didCompleteWithValues: self.currentValues)
        }
    }

}

extension XVSFormViewController : FieldCellDelegate {
    
    func cell(forField field: XVSField, changedToValue value: Any?) {
        updateCompletionAvailability()
    }
    
}
