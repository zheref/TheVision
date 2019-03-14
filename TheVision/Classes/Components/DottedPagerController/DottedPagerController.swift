//
//  DottedPagerController.swift
//  TheVision
//
//  Created by Sergio Daniel on 2/28/19.
//

import UIKit

public enum DottedPagerError : Error {
    
}

public protocol DottedPagerDelegate : class {
    
    var pages: [UIViewController] { get }
    
}

public class DottedPagerController: UIViewController {
    
    // - MARK: CONSTANTS
    
    let dottedPagerSubpagerSegue = "dottedPagerSubpager"
    
    // - MARK: STORED PROPERTIES
    
    public weak var delegate: DottedPagerDelegate?
    var currentPageIndex: Int = -1 {
        didSet {
            dotsPageControl.currentPage = currentPageIndex
        }
    }
    
    // - MARK: OUTLETS
    
    @IBOutlet weak var dotsPageControl: UIPageControl!
    @IBOutlet weak var subpagerView: UIView!
    
    @IBOutlet var subpager: PagerViewController?
    
    // MARK: - INITIALIZERS
    
    public static func create() -> DottedPagerController {
        let storyboard = UIStoryboard(name: String(describing: DottedPagerController.self), bundle: Bundle(for: DottedPagerController.self))
        return storyboard.instantiateInitialViewController() as! DottedPagerController
    }
    
    // MARK: - LIFECYCLE

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if let number = delegate?.pages.count {
            dotsPageControl.numberOfPages = number
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == dottedPagerSubpagerSegue {
            subpager = segue.destination as? PagerViewController
            setupSubpager()
        }
    }
    
    // MARK: - PUBLIC OPERATIONS
    
    public func goNext() {
        subpager?.moveToNextPage()
        updateDots()
    }
    
    // MARK: - PRIVATE OPERATIONS
    
    private func setupSubpager() {
        subpager?.delegate = self
        subpager?.dataSource = self
        
        guard let delegate = delegate else {
            print("TheVision Error >>>>> Delegate for DottedPageController not available (is nil)")
            return
        }
        
        if delegate.pages.count > 0 {
            currentPageIndex = 0
            
            let firstPageController = delegate.pages[currentPageIndex]
            subpager?.setViewControllers([firstPageController], direction: .forward, animated: true, completion: nil)
        } else {
            print("TheVision Warning >>>> DottedPager has no page view controllers to display. Is this intentional?")
        }
    }
    
    private func setupConstraints() {
        
    }
    
    private func updateDots() {
        guard let delegate = delegate, let pageViewController = subpager else {
            return
        }
        
        let pageContentViewController = pageViewController.viewControllers![0]
        currentPageIndex = delegate.pages.index(of: pageContentViewController) ?? 0
    }

}

extension DottedPagerController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        updateDots()
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let delegate = delegate else {
            return nil
        }
        
        guard let viewControllerIndex = delegate.pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let backIndex = viewControllerIndex - 1
        
        guard backIndex >= 0 else {
            return nil
        }
        
        guard delegate.pages.count > backIndex else {
            return nil
        }
        
        return delegate.pages[backIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let delegate = delegate else {
            return nil
        }
        
        guard let viewControllerIndex = delegate.pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let count = delegate.pages.count
        
        guard count != nextIndex else {
            return nil
        }
        
        guard count > nextIndex else {
            return nil
        }
        
        return delegate.pages[nextIndex]
    }
    
}
