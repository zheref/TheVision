//
//  DarkTouchTweaker.swift
//  Vision
//
//  Created by Sergio Lozano García on 6/6/18.
//  Copyright © 2018 Sergio Lozano García. All rights reserved.
//

import UIKit

class DarkTouchTweaker {
    
    // MARK: - Subtypes
    
    struct Color {
        static let backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        
        static let textFieldsColor = UIColor(red: 0.282, green: 0.282, blue: 0.282, alpha: 1.0)
        static let textFieldsPlaceholderForeground = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        
        static let separatorsColor = UIColor(red: 0.369, green: 0.369, blue: 0.369, alpha: 1.0)
    }
    
    static func setDarkMode(viewController: UIViewController) -> Void {
        viewController.view.backgroundColor = Color.backgroundColor
        
        viewController.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        viewController.navigationController?.navigationBar.tintColor = UIColor.white
        viewController.navigationController?.navigationBar.barStyle = UIBarStyle.black
        viewController.tabBarController?.tabBar.barStyle = UIBarStyle.black
    }
    
}
