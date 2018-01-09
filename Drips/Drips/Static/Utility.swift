//
//  Utility.swift
//  Drips
//
//  Created by James Fong on 2018-01-08.
//  Copyright © 2018 James Fong. All rights reserved.
//

import Foundation

extension UIView {

static func imageWithView(view:UIView)->UIImage{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
    view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}
}
