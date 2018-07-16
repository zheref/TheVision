//
//  MainTableViewController.swift
//  VisionDemo
//
//  Created by Sergio Daniel L. García on 6/7/18.
//  Copyright © 2018 Sergio Lozano García. All rights reserved.
//

import UIKit
import TheVision

class MainTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var loginViewCell: UITableViewCell!
    @IBOutlet weak var loginModalViewCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell == loginViewCell {
            showLoginForm()
        } else if cell == loginModalViewCell {
            showLoginFormModally()
        }
    }
    
    private func showLoginForm() {
        let fields = [
            VSField(name: "email", title: "E-mail", type: .email, size: .regular),
            VSField(name: "password", title: "Password", type: .password, size: .regular)
        ]
        
        let vc = VSFormViewController.instantiate(withName: "login", fields: fields, delegate: self, options: [
            .mode: VSFormMode.action,
            .theme: VSFormTheme.dark,
            .actionCopy: "Login"
        ])
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showLoginFormModally() {
        let fields = [
            VSField(name: "email", title: "E-mail", type: .email, size: .regular),
            VSField(name: "password", title: "Password", type: .password, size: .regular),
            VSField(name: "action", title: "Custom Action", type: .action, size: .regular),
            VSField(name: "forward", title: "Go Forward", type: .action)
        ]
        
        let vc = VSFormViewController.instantiate(withName: "login", fields: fields, delegate: self, options: [
            .presentation: VSFormPresentation.modal,
            .mode: VSFormMode.action,
            .actionCopy: "Login"
        ])
        
        present(vc, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainTableViewController : VSFormViewControllerDelegate {
    
    func formView(_ viewController: VSFormViewController, didAbortWithValues values: VSFieldValues) {
        print(values)
    }
    
    func formView(_ viewController: VSFormViewController, didCompleteWithValues values: VSFieldValues) {
        print(values)
    }
    
    func formView(_ viewController: VSFormViewController, shouldAllowToCompleteWithValues values: VSFieldValues) -> Bool {
        var availability = false
        
        if let email = values["email"] as? String {
            availability = email.count > 0
        }
        
        return availability
    }
    
    func formView(_ viewController: VSFormViewController, shouldAllowToAbortWithValues values: VSFieldValues) -> Bool {
        return true
    }
    
    func formView(_ formViewController: VSFormViewController, emmitedActionFromField field: VSField, whileHavingValues values: VSFieldValues) {
        if field.name == "action" {
            formViewController.showOkAlert(title: "Worked", message: "Custom actions are working")
        } else if field.name == "forward" {
            let fields = [
                VSField(name: "wildcard", title: "Wildcard", type: .text, size: .regular)
            ]
            
            let vc = VSFormViewController.instantiate(withName: "wildcarding", fields: fields, delegate: self, options: [
                .mode: VSFormMode.action,
                .actionCopy: "Save"
            ])
            
            formViewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
