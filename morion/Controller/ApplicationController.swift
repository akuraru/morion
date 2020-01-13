protocol ApplicationController {
    var store: StoreController { get }
}

struct ApplicationControllerImp: ApplicationController  {
    var store: StoreController = StoreControllerImp()
}
