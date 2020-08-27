//
//  TabCollectionCell.swift
//  TabPageViewController
//
//  Created by EndouMari on 2016/02/24.
//  Copyright © 2016年 EndouMari. All rights reserved.
//

import UIKit

class TabCollectionCell: UICollectionViewCell {

    var tabItemButtonPressedBlock: (() -> Void)?
    var option: TabPageOption = TabPageOption()
    var item: TabItem! {
        didSet {
            if item.title == nil {
                itemLabel.isHidden = true
            }

            if let icon = item.icon {
                iconImageView.image = icon
            }
            else {
                iconImageView.isHidden = true
            }
            stackView.spacing = item.spacing
            itemLabel.invalidateIntrinsicContentSize()
            invalidateIntrinsicContentSize()
        }
    }
    var isCurrent: Bool = false {
        didSet {
            currentBarView.isHidden = !isCurrent
            if isCurrent {
                highlightTitle()
            } else {
                unHighlightTitle()
            }
            currentBarView.backgroundColor = option.currentColor
            layoutIfNeeded()
        }
    }

    @IBOutlet fileprivate weak var stackView: UIStackView!
    @IBOutlet fileprivate weak var stackLeading: NSLayoutConstraint!
    @IBOutlet fileprivate weak var stackTrailing: NSLayoutConstraint!
    @IBOutlet fileprivate weak var iconImageView: UIImageView!
    @IBOutlet fileprivate weak var itemLabel: UILabel!
    
    @IBOutlet fileprivate weak var roundedView: UIView!
    @IBOutlet fileprivate weak var roundedLeading: NSLayoutConstraint!
    @IBOutlet fileprivate weak var roundedTrailing: NSLayoutConstraint!
    @IBOutlet fileprivate weak var roundedHeight: NSLayoutConstraint!

    @IBOutlet fileprivate weak var currentBarView: UIView!
    @IBOutlet fileprivate weak var currentBarViewHeightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        currentBarView.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        roundedView.backgroundColor = UIColor.clear
        currentBarView.isHidden = false
        
        iconImageView.isHidden = false
        itemLabel.isHidden = false
        itemLabel.attributedText = nil
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch option.markerStyle {
        case .none:
            currentBarViewHeightConstraint.constant = 0
            
        case .bar(height: let height):
            currentBarViewHeightConstraint.constant = height
            
        case .rounded(height: let height):
            currentBarViewHeightConstraint.constant = 0
            
            // height
            roundedHeight.constant = height

            // padding left
            stackLeading.constant = option.tabPadding
            // padding right
            stackTrailing.constant = option.tabPadding

            
            // margin left
            roundedLeading.constant = option.tabMargin
            // margin right
            roundedTrailing.constant = option.tabMargin
            
            roundedView.layer.cornerRadius = height / 2
        }
    }

    class func cellIdentifier() -> String {
        return "TabCollectionCell"
    }
}


// MARK: - View

extension TabCollectionCell {
    override var intrinsicContentSize : CGSize {
        let width: CGFloat
        if let tabWidth = option.tabWidth , tabWidth > 0.0 {
            width = tabWidth
        } else {
            width = item.itemWidth + option.tabPadding * 2 + option.tabMargin * 2
        }

        let size = CGSize(width: width, height: option.tabHeight)
        return size
    }

    func hideCurrentBarView() {
        currentBarView.isHidden = true
    }

    func showCurrentBarView() {
        currentBarView.isHidden = false
    }

    func highlightTitle() {
        roundedView.backgroundColor = option.defaultColor
        iconImageView.tintColor = option.currentColor
        
        guard let title = item.title else {
            return
        }
        var attributes = item.attributes
        attributes[.foregroundColor] = option.currentColor
        itemLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
    }

    func unHighlightTitle() {
        roundedView.backgroundColor = nil
        iconImageView.tintColor = option.defaultColor
        
        guard let title = item.title else {
            return
        }
        var attributes = item.attributes
        attributes[.foregroundColor] = option.defaultColor
        itemLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
    }
}


// MARK: - IBAction

extension TabCollectionCell {
    @IBAction fileprivate func tabItemTouchUpInside(_ button: UIButton) {
        tabItemButtonPressedBlock?()
    }
}
