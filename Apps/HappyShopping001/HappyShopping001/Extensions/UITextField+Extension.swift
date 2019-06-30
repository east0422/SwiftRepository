//
//  UITextField+Extension.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-24.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit

// 扩展输入框顶部自定义完成按钮
private var TextFieldToolBarParamKey = "TextFieldToolBarParamKey"

extension UITextField {
    var toolBar: UIToolbar? {
        set(toolBar) {
            objc_setAssociatedObject(self, &TextFieldToolBarParamKey, toolBar, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &TextFieldToolBarParamKey) as? UIToolbar
        }
    }
    
    // 显示顶部自定义完成按钮
    func showToolBar() {
        setupToolBar()
        self.inputAccessoryView = toolBar
    }
    
    func setupToolBar() {
        toolBar = UIToolbar()
        
        // 可以让UIBarButtonItem靠右显示
        let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(doneItemDidClick))
        
        toolBar?.sizeToFit()
        toolBar?.items = [spaceItem, doneItem]
    }
    
    @objc func doneItemDidClick() {
        self.resignFirstResponder()
    }
}
