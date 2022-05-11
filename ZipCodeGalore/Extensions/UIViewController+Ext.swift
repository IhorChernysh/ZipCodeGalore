//
//  UIViewController+Ext.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 12.05.2022.
//

import Foundation
import UIKit
import SnapKit

extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Alert
    func createAlert(title: String? = "Something wrong",
                     message: String?,
                     actions: [UIAlertAction] = [UIAlertAction(title: "Okay", style: .default, handler: nil)],
                     style: UIAlertController.Style) -> UIAlertController {
        let alertContoller = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach {
            alertContoller.addAction($0)
        }
        return alertContoller
    }
 
    // MARK: Keyboard Observers
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
