//
//  BottomPopupPresentationController.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import UIKit

final class BottomPopupPresentationController: UIPresentationController {
            
    // MARK: -Variables and Intializers
    static let screenHeight = UIScreen.main.bounds.size.height
    private let interactor = UIPercentDrivenInteractiveTransition()
    private let dimmingView = UIView()
    private var propertyAnimator: UIViewPropertyAnimator!
    private var isInteractive = false
   
    var popupVariables = BottomPopupVariables()
    var delegateBottomPopupManagable: BottomPopupManageable?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.edgesForExtendedLayout = .bottom;
        presentedViewController.extendedLayoutIncludesOpaqueBars = true
    }
    
    func updateBottomPageViewHeight(){
        if let validDelegate = delegateBottomPopupManagable {
            popupVariables = validDelegate.updateBottomPopup()
            let bottomPadding = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
            let finalHeight = popupVariables.pageHeight + bottomPadding
            popupVariables.pageHeight = min(finalHeight, BottomPopupPresentationController.screenHeight)
        }
    }
    
    // MARK: -Function Overrides
    
    override var presentedView: UIView? {
        guard let containerBounds = containerView?.bounds else { return nil }
        var frame = containerBounds
        frame.size.height = popupVariables.pageHeight
        frame.origin.y = containerBounds.height - popupVariables.pageHeight
        super.presentedView?.frame = frame
        return super.presentedView
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
                
        guard let containerBounds = containerView?.bounds else { return }
        
        // Add Pangestrure and corner radius
        if popupVariables.isPanGestureEnable {
            presentedView?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        }
        let path = UIBezierPath(roundedRect: containerBounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: popupVariables.pageCornerRadius, height: popupVariables.pageCornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        presentedView?.layer.mask = mask
        
        // Add a dimming view below the presented view controller, and a tap gesture recognizer to it for dismissal.
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
        dimmingView.backgroundColor = .black
        dimmingView.frame = containerBounds
        dimmingView.alpha = 0
        containerView?.insertSubview(dimmingView, at: 0)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (transitionContext) in
            guard let self = self else { return }
            self.dimmingView.alpha = self.popupVariables.pageIntermediateDimmingValue
            })
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (transitionContext) in
            guard let self = self else { return }
            self.dimmingView.alpha = 0
            })

    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            delegateBottomPopupManagable?.pageDismissed(presentedViewController)
        }
    }
    
    // MARK: -Private Functions
    @objc private func dismiss() {
        presentedViewController.dismiss(animated: true)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let gestureView = gesture.view,
            gesture.translation(in: gestureView).y >= 0 else { return } // Make sure we only recognize downward gestures.
                
        let percent = gesture.translation(in: gestureView).y / gestureView.bounds.height
        
        switch gesture.state {
        case .began:
            isInteractive = true
            presentedViewController.dismiss(animated: true, completion: nil)
        case .changed:
            interactor.update(percent)
        case .cancelled:
            interactor.cancel()
            isInteractive = false
        case .ended:
            let velocity = gesture.velocity(in: gestureView).y
            // Finish the animation if the user flicked the modal quickly (i.e. high velocity), or dragged it more than 50% down.
            if percent > 0.5 || velocity > 1600 {
                // Multiply the animation duration by the velocity, to make sure the modal dismisses as fast as the user swiped.
                // If the user pulled down slowly though, we want to use the default duration, hence the max().
                interactor.completionSpeed = max(1, velocity / (gestureView.frame.height * (1 / interactor.duration)))
                interactor.finish()
            } else {
                interactor.cancel()
            }
            isInteractive = false
        default:
            break
        }
    }

}

// MARK: -UIViewControllerAnimatedTransitioning
extension BottomPopupPresentationController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        popupVariables.pageAnimationTiming
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        interruptibleAnimator(using: transitionContext).startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        propertyAnimator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext),
                                                  timingParameters: UICubicTimingParameters())
        propertyAnimator.addAnimations { [weak transitionContext] in
           guard let transitionContext = transitionContext else { return }
            transitionContext.view(forKey: .from)?.frame.origin.y = transitionContext.containerView.frame.maxY
        }
        propertyAnimator.addCompletion { [weak transitionContext] _ in
           guard let transitionContext = transitionContext else { return }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        return propertyAnimator
    }
    
}

// MARK: -UIViewControllerTransitioningDelegate
extension BottomPopupPresentationController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        isInteractive ? interactor : nil
    }

}

//MARK: CenterPopupVariables Structure
struct BottomPopupVariables {
    var pageHeight = BottomPopupPresentationController.screenHeight
    var pageAnimationTiming = 0.4
    var pageCornerRadius = CGFloat(0)
    var pageIntermediateDimmingValue = CGFloat(0.4)
    var isPanGestureEnable = true
}

protocol BottomPopupManageable {
    func updateBottomPopup() -> BottomPopupVariables
    func pageDismissed(_ presentedController: UIViewController)
}

extension BottomPopupManageable {
    func pageDismissed(_ presentedController: UIViewController) {}
}


// MARK: -UIViewController Extension
extension UIViewController {
    
    func presentWithBottomPopupPresentationController<T>(_ viewController: T) where T:UIViewController , T:BottomPopupManageable {
        let presentationController = BottomPopupPresentationController(presentedViewController: viewController, presenting: self)
        presentationController.delegateBottomPopupManagable = viewController
        presentationController.updateBottomPageViewHeight()
        viewController.transitioningDelegate = presentationController
        viewController.modalPresentationStyle = .custom
        if let validNavigationController = navigationController {
            validNavigationController.present(viewController, animated: true)
        } else {
            present(viewController, animated: true)
        }
        
    }
    
}

