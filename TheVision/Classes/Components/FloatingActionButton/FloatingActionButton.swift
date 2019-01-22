//
//  FloatingActionButton.swift
//  TheVision
//
//  Created by Sergio Daniel on 1/15/19.
//

import UIKit
import PowerStone
import SnapKit

public class VSFloatingActionButton : UIButton {
    
    var tapActionHandler: PSHandler?
    
    public static func add(to view: UIView, withInfo info: VSFloatingActionInfo, andAction action: @escaping PSHandler) -> VSFloatingActionButton {
        let button = VSFloatingActionButton(frame: info.frame)
        button.setImage(info.iconImage, for: .normal)
        
        view.addSubview(button)
        button.attach(to: info.position, with: info.frame, on: view)
        
        button.tapActionHandler = action
        
        return button
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTap(sender:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OPERATIONS
    
    func attach(to position: VSFloatingActionPosition, with frame: CGRect, on parent: UIView) {
        switch position {
        case .topLeft:
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: frame.origin.x).isActive = true
            topAnchor.constraint(equalTo: parent.topAnchor, constant: frame.origin.y).isActive = true
            heightAnchor.constraint(equalToConstant: frame.height).isActive = true
            widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        case .bottomLeft:
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: frame.origin.x).isActive = true
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -frame.origin.y).isActive = true
            heightAnchor.constraint(equalToConstant: frame.height).isActive = true
            widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        case .topRight:
            trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -frame.origin.x).isActive = true
            topAnchor.constraint(equalTo: parent.topAnchor, constant: frame.origin.y).isActive = true
            heightAnchor.constraint(equalToConstant: frame.height).isActive = true
            widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        case .bottomRight:
            trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -frame.origin.x).isActive = true
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -frame.origin.y).isActive = true
            heightAnchor.constraint(equalToConstant: frame.height).isActive = true
            widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        }
    }
    
    // MARK: - ACTIONS
    
    @objc private func userDidTap(sender: UITapGestureRecognizer) {
        tapActionHandler?()
    }
    
}
