//
//  SwipeableTableViewCell.swift
//  TheVision
//
//  Created by Sergio Daniel on 5/2/19.
//

import UIKit

public class VSSwipeableTableViewCell: UITableViewCell {
    
    // MARK: - OUTLETS
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var scrollViewContentView: UIView!
    @IBOutlet var scrollViewLabel: UILabel!
    
    // MARK: - LIFECYCLE
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSwipableBehaviour()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSwipableBehaviour()
    }
    
    // MARK: - PRIVATE OPERATIONS

    private func setupSwipableBehaviour() {
        // Create the scroll view which enables the horizontal swiping.
        let scrollView = UIScrollView(frame: bounds)
        scrollView.autoresizingMask = .flexibleWidth
        scrollView.contentSize = bounds.size
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 160, bottom: 0, right: 0)
        scrollView.delegate = self
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        contentView.addSubview(scrollView)
        self.scrollView = scrollView
        
        // Set up main content area.
        let contentView = UIView(frame: scrollView.bounds)
        contentView.autoresizingMask = .flexibleWidth
        contentView.backgroundColor = UIColor.white
        scrollView.addSubview(contentView)
        self.scrollViewContentView = contentView
        
        // Put a label in the scroll view content area.
        let label = UILabel(frame: contentView.bounds.insetBy(dx: 10, dy: 0))
        label.autoresizingMask = .flexibleWidth
        self.scrollViewContentView.addSubview(label)
        self.scrollViewLabel = label
    }

}

extension VSSwipeableTableViewCell : UIScrollViewDelegate {
    
    
    
}
