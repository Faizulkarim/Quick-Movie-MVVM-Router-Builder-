//
//  BottomPopupPresentationController.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import UIKit

class CenterPopupPresentationController : UIPresentationController {
    
    private let dimmingView = UIView()
    private var popupVariables: CenterPopupVariables!
    
    var delegateFrameManageable: CenterPopupManageable?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    func updatePopupViewFrame(){
        if let validDelegate = delegateFrameManageable {
            self.popupVariables = validDelegate.updateCenterPopup()
        }
    }
    
    // MARK: -Function Overrides
    override var presentedView: UIView? {
        super.presentedView?.frame = popupVariables.animationPopupFrame
        return super.presentedView
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        guard let containerBounds = containerView?.bounds else { return }
        
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
        dimmingView.backgroundColor = .black
        dimmingView.frame = containerBounds
        dimmingView.alpha = 0
        containerView?.insertSubview(dimmingView, at: 0)
        self.dimmingView.alpha = self.popupVariables.animationPopupAlpha
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        self.dimmingView.alpha = 0
    }
    
    // MARK: -Private Functions
    @objc private func dismiss() {
        presentedViewController.dismiss(animated: true)
    }
}

// MARK: -UIViewControllerTransitioningDelegate
extension CenterPopupPresentationController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let popupAnimation = AnimationPopup()
        popupAnimation.forward = true
        popupAnimation.popupVariables = popupVariables
        return popupAnimation
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      let popupAnimation = AnimationPopup()
        popupAnimation.forward = false
       popupAnimation.popupVariables = popupVariables
       return popupAnimation
    }

}

// MARK:- AnimationPopup used for transition.
class AnimationPopup: NSObject, UIViewControllerAnimatedTransitioning {
    
    var forward = true
    var popupVariables: CenterPopupVariables!
    
    // Can be customise from outside (currently not)
    var originFrame = CGRect.zero
    
    // MARK: - UIViewControllerAnimatedTransitioning Delegate
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return popupVariables.animationTiming
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        //var originView: UIView!
        var animatedView: UIView!
        
        if self.forward {
            let animatedViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            animatedView = animatedViewController?.view
            animatedView.frame = transitionContext.finalFrame(for: animatedViewController!)
           // originView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view
            containerView.addSubview(animatedView)
        } else {
            animatedView =  transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view
        }
        originFrame = animatedView.frame
        var startFrame: CGRect!
        var endFrame: CGRect!
        
        if self.forward {
            startFrame = self.originFrame
            endFrame = animatedView.frame
        } else {
            startFrame = animatedView.frame
            endFrame = self.originFrame
        }
        animatedView.layer.cornerRadius = popupVariables.animationPopupCornerRadius
        animatedView.layer.masksToBounds = true
        animatedView.frame = startFrame
        UIView.animate(withDuration: popupVariables.animationTiming, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            animatedView.frame = endFrame
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
        
    }
    
}

//MARK: CenterPopupVariables Structure
struct CenterPopupVariables {
    var animationTiming = Double(0.35)
    var animationPopupAlpha = CGFloat(0.4)
    var animationPopupCornerRadius = CGFloat(5)
    var animationPopupFrame = CGRect(x: 10, y: 10, width: UIScreen.main.bounds.size.width-20, height: UIScreen.main.bounds.size.height-20)
    
}

//MARK: PopupManageable Protocol
protocol CenterPopupManageable {
    func updateCenterPopup() -> CenterPopupVariables
}

extension CenterPopupManageable {
    func updateCenterPopup() -> CenterPopupVariables {
        return CenterPopupVariables()
    }
}

// MARK: UIViewController Extension
extension UIViewController {
    
    func presentWithCenterPopupPresentationController<T>(_ viewController: T) where T:UIViewController , T:CenterPopupManageable {
        let presentationController = CenterPopupPresentationController(presentedViewController: viewController, presenting: self)
        presentationController.delegateFrameManageable = viewController
        presentationController.updatePopupViewFrame()
        viewController.transitioningDelegate = presentationController
        viewController.modalPresentationStyle = .custom
        if let validNavigationController = navigationController {
            validNavigationController.present(viewController, animated: true)
        } else {
            present(viewController, animated: true)
        }
    }
    
}

