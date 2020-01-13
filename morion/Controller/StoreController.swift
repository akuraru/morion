import Foundation

protocol StoreController: LoggedOutStoreController {
}

class StoreControllerImp: StoreController {
    let tokenKey = "token"
    func set(token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
}
