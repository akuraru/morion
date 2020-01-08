//
//  RootRouter.swift
//  morion
//
//  Created by akuraru on 2020/01/07.
//  Copyright © 2020 akuraru. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(_ viewControllable: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    init(interactor: RootInteractable, viewController: RootViewControllable, loggedOutBuilder: LoggedOutBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    let loggedOutBuilder: LoggedOutBuildable

    override func didLoad() {
        super.didLoad()
        
        let router = loggedOutBuilder.build(withListener: interactor)
        attachChild(router)
        viewController.present(router.viewControllable)
    }
}
