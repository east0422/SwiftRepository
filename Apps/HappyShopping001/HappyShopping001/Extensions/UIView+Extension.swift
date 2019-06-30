//
//  UIView+Extension.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-28.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit

extension UIView {
    // 返回该view所在viewcontroller
    func firstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: {$0?.superview}) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self) {
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
}
