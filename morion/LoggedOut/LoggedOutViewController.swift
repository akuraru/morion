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

protocol LoggedOutPresentableListener: class {
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
    weak var listener: LoggedOutPresentableListener?
    
    func instantiate() -> LoggedOutViewController {
        let storyboard = UIStoryboard(name: "LoggedOutViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? LoggedOutViewController else { fatalError() }
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    @IBOutlet weak var tokenField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
