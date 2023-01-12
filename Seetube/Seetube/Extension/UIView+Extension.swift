//
//  UIView+Extension.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/11.
//

import UIKit

@IBDesignable
extension UIView {
    static func loadFromNib<T>() -> T? {
        let identifier = String(describing: T.self)
        let view = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first
        return view as? T
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
}
