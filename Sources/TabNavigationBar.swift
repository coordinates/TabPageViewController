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
        if #available(iOS 13, *) {
            // none
            // iOS 13 では layoutMargin を弄ると落ちる。
            // Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Client error attempting to change layout margins of a private view'
        }
        else if #available(iOS 11, *) {
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
            guard let tabView = super.subviews.first(where: { (subview) -> Bool in
                subview is TabView
            }) else {
                return
            }

            var frame = tabView.frame
            frame.origin.x = 0
            tabView.frame = frame
        }
    }
}
