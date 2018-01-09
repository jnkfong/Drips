//
//  BaseViewController.swift
//  Drips
//
//  Created by James Fong on 2018-01-08.
//  Copyright © 2018 James Fong. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if(text == "\n") {
//            textView.resignFirstResponder()
//            return false
//        }
//        return true
//    }
    
    func getBlurEffectView(style: UIBlurEffectStyle, frame: CGRect, alpha: CGFloat)->UIVisualEffectView {
        let blur = UIBlurEffect(style: style)
        let blurredEffectView = UIVisualEffectView(effect: blur)
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurredEffectView.alpha = alpha
        blurredEffectView.frame = frame
        return blurredEffectView
    }

    func imageWithView(view:UIView)->UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
