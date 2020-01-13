//
//  LoggedOutBuilder.swift
//  morion
//
//  Created by akuraru on 2020/01/07.
//  Copyright © 2020 akuraru. All rights reserved.
//

import RIBs

protocol LoggedOutDependency: Dependency {
    var application: ApplicationController { get }
}

final class LoggedOutComponent: Component<LoggedOutDependency> {
    var application: ApplicationController { dependency.application }
}

// MARK: - Builder

protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {

    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        let component = LoggedOutComponent(dependency: dependency)
        let viewController = LoggedOutViewController.instantiate()
        let interactor = LoggedOutInteractor(presenter: viewController, storeController: component.application.store)
        interactor.listener = listener
        return LoggedOutRouter(interactor: interactor, viewController: viewController)
    }
}
