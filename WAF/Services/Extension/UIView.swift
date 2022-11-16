//
//  UIView.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]){
        views.forEach { addSubview($0)}
    }
}
