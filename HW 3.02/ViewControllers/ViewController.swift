//
//  ViewController.swift
//  HW 3.02
//
//  Created by Vasyl Larin on 05.11.2022.
//

import UIKit

let jokeURL = "https://official-joke-api.appspot.com/random_joke"

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var jokeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func randomJokeButton(_ sender: Any) {
        getRandomJoke()
    }
    
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
}

extension ViewController {
    private func getRandomJoke() {
        guard let url = URL(string: jokeURL) else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
        
        
//        guard let url = URL(string: jokeURL) else { return }
//
//        URLSession.shared.dataTask(with: url) { [weak self]  data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            let decoder = JSONDecoder()
//            do {
//                let joke = try decoder.decode(Joke.self, from: data)
//                print(joke)
//                self?.showAlert(withStatus: .success)
//            } catch let error {
//                self?.showAlert(withStatus: .failed)
//                print(error.localizedDescription)
//            }
//        }.resume()
    }
}
