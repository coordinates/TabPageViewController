//
//  TabItem.swift
//  TabPageViewController
//
//  Created by Masayoshi Ukida on 2019/07/09.
//

import Foundation
import UIKit

public class TabItem {
    public let title: String?
    public let icon: UIImage?
    public var font: UIFont = UIFont.systemFont(ofSize: 10)
    public var spacing: CGFloat = 8.0
    
    public init(title: String? = nil, icon: UIImage? = nil) {
        self.title = title
        self.icon = icon
        
        guard title != nil || icon != nil else {
            fatalError("required title or icon")
        }
    }
    
    var itemWidth: CGFloat {
        var width: CGFloat = 0.0
        
        if let title = title as NSString? {
            var attributes: [NSAttributedString.Key: Any] = [:]
            // フォーカス時に bold が指定されると省略されるので bold で計算する
            attributes[.font] = UIFont.boldSystemFont(ofSize: font.pointSize)
            
            let size = title.size(withAttributes: attributes)
            width += ceil(size.width)
        }
        
        if let icon = icon {
            if let title = title, !title.isEmpty {
                width += spacing
            }
            width += icon.size.width
        }
        
        return width
    }
}
