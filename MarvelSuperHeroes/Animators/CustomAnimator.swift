//
//  CustomAnimator.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 20/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import UIKit

protocol CustomAnimatorProtocol {

    func frameToAnimate() -> CGRect
}

class CustomAnimator : NSObject {

    private let duration: TimeInterval
    private let originFrame: CGRect
    private let image: UIImage
    private var isPresenting: Bool
    private var originFrameC: CustomAnimatorProtocol?
    private var finalFrameC: CustomAnimatorProtocol?

    public let CustomAnimatorTag = 99

    init(duration: TimeInterval, originFrame: CGRect, image: UIImage?, _ originFrameC: CustomAnimatorProtocol, _ finalFrameC: CustomAnimatorProtocol) {

        self.duration = duration
        self.isPresenting = true
        self.originFrame = originFrame
        self.image = image ?? UIImage()
        self.originFrameC = originFrameC
        self.finalFrameC = finalFrameC
    }

    func push() -> CustomAnimator {

        self.isPresenting = true
        return self
    }

    func pop() -> CustomAnimator {

        self.isPresenting = false
        return self
    }
}

extension CustomAnimator: UIViewControllerAnimatedTransitioning {

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let fromView = transitionContext.view(forKey: .from) else { return transitionContext.completeTransition(false) }
        guard let toView = transitionContext.view(forKey: .to) else { return transitionContext.completeTransition(false) }

        let container = transitionContext.containerView
        let detailView = self.isPresenting ? toView : fromView

        guard let imgViewDetailView = detailView.viewWithTag(CustomAnimatorTag) as? UIImageView else { return transitionContext.completeTransition(false) }

        guard let originFrameC = self.originFrameC else {return}

        imgViewDetailView.alpha = 0

        if self.isPresenting {

            container.addSubview(toView)
            detailView.frame = CGRect(x: fromView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            detailView.alpha = 0
            detailView.layoutIfNeeded()

        } else {

            container.insertSubview(toView, belowSubview: fromView)
        }

        let transitionImageView = UIImageView(image: image)
        transitionImageView.frame = self.isPresenting ? originFrameC.frameToAnimate()/*self.originFrame*/ : imgViewDetailView.convert(imgViewDetailView.frame, to: detailView.superview)
        transitionImageView.clipsToBounds = true
        transitionImageView.contentMode = UIView.ContentMode.scaleAspectFill

        container.addSubview(transitionImageView)

        UIView.animate(withDuration: duration, animations: {

            detailView.frame = self.isPresenting ? fromView.frame : CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            detailView.alpha = self.isPresenting ? 1 : 0
            transitionImageView.frame = self.isPresenting ? imgViewDetailView.convert(imgViewDetailView.frame, to: toView.superview) : originFrameC.frameToAnimate()/*self.originFrame*/

        }) { _ in

            let success = !transitionContext.transitionWasCancelled
            if !success { toView.removeFromSuperview() }

            transitionContext.completeTransition(success)
            transitionImageView.removeFromSuperview()
            imgViewDetailView.alpha = 1
        }
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {

        return duration
    }
}
