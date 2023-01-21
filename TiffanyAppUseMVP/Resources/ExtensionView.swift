//
//  ExtensionView.swift
//  TiffanyAppUseMVP
//
//  Created by sss on 21.01.2023.
//

import UIKit

extension UIView {
    func addSubviews( _ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
