//
//  NavigationBar.swift
//  TabPageViewControllerTests
//
//  Created by Masayoshi Ukida on 2019/07/10.
//

import UIKit

public class TabNavigationBar: UINavigationBar {
    var originalLayoutMargins: UIEdgeInsets = .zero
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // 左の _UIButtonBarStackView だけ詰めたい
        if #available(iOS 11, *) {
            for subview in super.subviews {
                guard NSStringFromClass(type(of: subview)) == "_UINavigationBarContentView" else {
                    continue
                }
                
                // back item の時は詰まっているので気にしない
                if originalLayoutMargins == .zero {
                    originalLayoutMargins = subview.layoutMargins
                }
                
                if subview.subviews.first(where: { (view) -> Bool in
                    view is TabView
                }) != nil {
                    var margins = subview.layoutMargins
                    margins.left = 0
                    subview.layoutMargins = margins
                } else {
                    subview.layoutMargins = originalLayoutMargins
                }
            }
        } else {
        }
    }
}
