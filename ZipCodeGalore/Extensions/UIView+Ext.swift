//
//  UIView+Ext.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 12.05.2022.
//

import UIKit
import JGProgressHUD

extension UIView {
    
    // MARK: - Blur
    
    func createBlurOverlay(blurEffectAlpha: CGFloat) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = blurEffectAlpha
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
    
    func removeBlurOverlay() {
        let blurredEffectViews = subviews.filter { $0 is UIVisualEffectView }
        blurredEffectViews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - Add and remove spinner
    
    func addSpinner(progressHud: JGProgressHUD) {
        let blurOverlay = self.createBlurOverlay(blurEffectAlpha: 0.7)
        self.addSubview(blurOverlay)
        progressHud.show(in: self)
    }
    
    func removeSpinner(progressHud: JGProgressHUD) {
        progressHud.dismiss()
        self.removeBlurOverlay()
    }
}
