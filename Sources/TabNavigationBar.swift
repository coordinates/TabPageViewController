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
        
        // 左の _UIButtonBarStackView だけ詰める
        if #available(iOS 11, *) {
            for subview in super.subviews {
                guard NSStringFromClass(type(of: subview)) == "_UINavigationBarContentView" else {
                    continue
                }
                
                // back item の時は詰まっているので気にしない
                var margins = subview.layoutMargins
                margins.left = 0
                subview.layoutMargins = margins
            }
        } else {
        }
    }
}
