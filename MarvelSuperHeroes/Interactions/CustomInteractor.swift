//
//  CustomInteraction.swift
//  MarvelSuperHeroes
//
//  Created by Marina Camilo on 26/11/2018.
//  Copyright © 2018 Marina Camilo. All rights reserved.
//

import UIKit

class CustomInteractor: UIPercentDrivenInteractiveTransition {

    private var navigationController : UINavigationController
    private var shouldCompleteTransition = false
    var transitionInProgress = false

    init?(attachTo viewController : UIViewController) {

        if let nav = viewController.navigationController {

            self.navigationController = nav
            super.init()

            self.setupBackGesture(view: navigationController.view)

        } else {

            return nil
        }
    }

    private func setupBackGesture(view : UIView) {

        let swipeBackGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleBackGesture(_:)))
        swipeBackGesture.edges = .left
        view.addGestureRecognizer(swipeBackGesture)
    }

    @objc private func handleBackGesture(_ gesture : UIScreenEdgePanGestureRecognizer) {
        
        let viewTranslation = gesture.translation(in: gesture.view?.superview)
        let progress = viewTranslation.x / self.navigationController.view.frame.width

        switch gesture.state {

        case .began:
            self.transitionInProgress = true
            self.navigationController.popViewController(animated: true)
            break

        case .changed:
            self.shouldCompleteTransition = progress > 0.5
            self.update(progress)
            break

        case .cancelled:
            self.transitionInProgress = false
            self.cancel()
            break

        case .ended:
            self.transitionInProgress = false
            self.shouldCompleteTransition ? self.finish() : self.cancel()
            break

        default:
            return
        }
    }
}
