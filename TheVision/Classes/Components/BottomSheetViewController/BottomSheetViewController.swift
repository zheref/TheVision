//
//  BottomSheetViewController.swift
//  TheVision
//
//  Created by Sergio Daniel on 2/4/19.
//

import UIKit

open class BottomSheetViewController: UIViewController {
    
    open var initialHeight: CGFloat {
        return 135.0
    }
    
    open var finalHeight: CGFloat? {
        return nil
    }
    
    open var effectStyle: UIBlurEffect.Style? {
        return nil
    }
    
    open var draggable: Bool {
        return true
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if draggable {
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(BottomSheetViewController.panGesture))
            view.addGestureRecognizer(gesture)
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateToReflectSize()
    }
    
    open func animateToReflectSize() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else {
                return
            }
            
            let frame = self.view.frame
            let yComponent = UIScreen.main.bounds.height - self.initialHeight
            
            let height = self.finalHeight ?? frame.height
            self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: height)
        }
    }
    
    func prepareBackgroundView() {
        guard let style = effectStyle else {
            return
        }
        
        let blurEffect = UIBlurEffect(style: style)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        let bluredView = UIVisualEffectView(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        
        view.insertSubview(bluredView, at: 0)
    }
    
    // MARK: - ACTIONS
    
    @objc private func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let y = view.frame.minY
        
        let minimumY = UIScreen.main.bounds.height - (finalHeight ?? view.frame.height)
        let maximumY = UIScreen.main.bounds.height - initialHeight
        
        let newY = y + translation.y
        
        if newY >= minimumY, newY <= maximumY {
            view.frame = CGRect(x: 0, y: newY, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
    }

}