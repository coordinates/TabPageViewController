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
    var option: TabPageOption = TabPageOption() {
        didSet {
            currentBarViewHeightConstraint.constant = option.currentBarHeight
        }
    }
    var item: TabItem! {
        didSet {
            if let title = item.title {
                itemLabel.text = title
            }
            else {
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
    @IBOutlet fileprivate weak var iconImageView: UIImageView!
    @IBOutlet fileprivate weak var itemLabel: UILabel!
    @IBOutlet fileprivate weak var currentBarView: UIView!
    @IBOutlet fileprivate weak var currentBarViewHeightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        currentBarView.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.isHidden = false
        itemLabel.isHidden = false
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
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
            width = item.width + option.tabMargin * 2
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
        iconImageView.tintColor = option.currentColor
        itemLabel.textColor = option.currentColor
        itemLabel.font = UIFont.boldSystemFont(ofSize: option.fontSize)
    }

    func unHighlightTitle() {
        iconImageView.tintColor = option.defaultColor
        itemLabel.textColor = option.defaultColor
        itemLabel.font = UIFont.systemFont(ofSize: option.fontSize)
    }
}


// MARK: - IBAction

extension TabCollectionCell {
    @IBAction fileprivate func tabItemTouchUpInside(_ button: UIButton) {
        tabItemButtonPressedBlock?()
    }
}
