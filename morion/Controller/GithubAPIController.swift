import Foundation

protocol GithubAPIController: LoggedOutAPIController {
}

class GithubAPIControllerImp: GithubAPIController {
    func user(token: String, complite: @escaping (Data?, Error?) ->()) {
        let url = URL(string: "https://api.github.com/user")!
        var request = URLRequest(url: url)
        request.addValue("token \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) {(data, request, error) in
            complite(data, error)
        }.resume()
    }
}

extension GithubAPIControllerImp: LoggedOutAPIController {
    func tokenCheck(token: String, complite: @escaping (Bool) -> ()) {
        user(token: token) { (data, error) in
            if let data = data,
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let _ = json["login"] {
                complite(true)
            } else {
                complite(false)
            }
        }
    }
}
