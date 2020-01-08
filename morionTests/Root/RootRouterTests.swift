//
//  RootRouterTests.swift
//  morionTests
//
//  Created by akuraru on 2020/01/08.
//  Copyright © 2020 akuraru. All rights reserved.
//

@testable import morion
import XCTest
import RIBs

final class RootRouterTests: XCTestCase {

    private var router: RootRouter!
    private var interracter: RootInteractMock!
    private var viewControllable: RootViewControllerMock!
    private var buildable: LoggedOutBuilderMock!

    override func setUp() {
        super.setUp()
        
        viewControllable = RootViewControllerMock()
        interracter = RootInteractMock(presenter: viewControllable)
        buildable = LoggedOutBuilderMock(dependency: EmptyComponent())
        router = RootRouter(interactor: interracter, viewController: viewControllable, loggedOutBuilder: buildable)
    }

    // MARK: - Tests

    func test_didLoad_routeToLoggedOut() {
        viewControllable.mock_present = {(viewControllable) in
            XCTAssertTrue(viewControllable is EmptyViewController)
        }
        router.didLoad()
    }
    
    // MARK: - Mock
    final class RootInteractMock: PresentableInteractor<RootPresentable>, RootInteractable {
        var router: RootRouting?
        var listener: RootListener?
    }
    
    final class RootViewControllerMock: RootViewControllable, RootPresentable {
        var listener: RootPresentableListener?
        var uiviewController = UIViewController()
        
        var mock_present: ((_ viewControllable: ViewControllable) -> ())?
        func present(_ viewControllable: ViewControllable) { self.mock_present?(viewControllable) }
    }
    
    final class LoggedOutBuilderMock: Builder<EmptyDependency>, LoggedOutBuildable {
        func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
            LoggedOutRoutingMock(interactor: listener)
        }
        
        final class LoggedOutRoutingMock: Router<Any>, LoggedOutRouting {
            var viewControllable: ViewControllable = EmptyViewController()
        }
    }
}

class EmptyViewController: UIViewController, ViewControllable {
}
