//
//  RootBuilder.swift
//  morion
//
//  Created by akuraru on 2020/01/07.
//  Copyright © 2020 akuraru. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    var application: ApplicationController { get }
}

final class RootComponent: Component<RootDependency>, LoggedOutDependency {
    var application: ApplicationController { return dependency.application }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> RootRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> RootRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        return RootRouter(interactor: interactor, viewController: viewController, loggedOutBuilder: loggedOutBuilder)
    }
}
