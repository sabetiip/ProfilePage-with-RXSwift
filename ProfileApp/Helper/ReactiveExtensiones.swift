//
//  ReactiveExtensiones.swift
//  ProfileApp
//
//  Created by Somayeh Sabeti on 2/4/21.
//  Copyright © 2021 Somayeh Sabeti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController: LoadingViewable {}

extension Reactive where Base: UIViewController {
    
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
    
}

extension UIViewController {
    func add(asChildViewController viewController: UIViewController,to parentView:UIView) {
        addChild(viewController)
        parentView.addSubview(viewController.view)
        viewController.view.frame = parentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}


