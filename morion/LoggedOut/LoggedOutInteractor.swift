//
//  LoggedOutInteractor.swift
//  morion
//
//  Created by akuraru on 2020/01/07.
//  Copyright © 2020 akuraru. All rights reserved.
//

import RIBs
import RxSwift

protocol LoggedOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoggedOutListener: class {
}

protocol LoggedOutStoreController: class {
    func set(token: String)
}

protocol LoggedOutAPIController: class {
    func tokenCheck(token: String, complite: @escaping (_ valid: Bool) -> ())
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {
    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?
    weak var storeController: LoggedOutStoreController?
    weak var apiController: LoggedOutAPIController?

    init(presenter: LoggedOutPresentable, storeController: LoggedOutStoreController, apiController: LoggedOutAPIController) {
        self.storeController = storeController
        self.apiController = apiController
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func login(token: String?) {
        guard let token = token else { return }
        
        apiController?.tokenCheck(token: token) {[weak self] (valid) in
            if valid {
                self?.storeController?.set(token: token)
            }
        }
    }
}
