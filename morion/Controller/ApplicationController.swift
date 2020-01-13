protocol ApplicationController {
    var store: StoreController { get }
    var api: GithubAPIController { get }
}

struct ApplicationControllerImp: ApplicationController  {
    var store: StoreController = StoreControllerImp()
    var api: GithubAPIController = GithubAPIControllerImp()
}
