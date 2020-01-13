//
//  LoggedOutViewController.swift
//  morion
//
//  Created by akuraru on 2020/01/07.
//  Copyright © 2020 akuraru. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import RxCocoa
import SnapKit

protocol LoggedOutPresentableListener: class {
    func login(token: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
    weak var listener: LoggedOutPresentableListener?
    
    static func instantiate() -> LoggedOutViewController {
        let storyboard = UIStoryboard(name: "LoggedOutViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? LoggedOutViewController else { fatalError() }
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    @IBOutlet weak var tokenField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        okButton.rx.tap
            .subscribe(onNext: { [weak self] () in
                self?.listener?.login(token: self?.tokenField.text)
            }).disposed(by: disposeBag)
    }
    
    let disposeBag = DisposeBag()
}
