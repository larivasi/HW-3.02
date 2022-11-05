//
//  ViewController.swift
//  HW 3.02
//
//  Created by Vasyl Larin on 05.11.2022.
//

import UIKit

let jokeURL = "https://official-joke-api.appspot.com/random_joke"

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var jokeTypeLabel: UILabel!
    @IBOutlet weak var jokeSetupLabel: UILabel!
    @IBOutlet weak var jokePunchlineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        getRandomJoke()
    }
    
    
    @IBAction func randomJokeButton(_ sender: UIButton) {
        getRandomJoke()
    }
}

extension ViewController {
    private func getRandomJoke() {
        guard let url = URL(string: jokeURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let joke = try decoder.decode(Joke.self, from: data)
                print(joke)
                DispatchQueue.main.async {
                    self?.jokeSetupLabel.text = joke.setup
                    self?.jokeTypeLabel.text = joke.type
                    self?.jokePunchlineLabel.text = joke.punchline
                    self?.activityIndicator.stopAnimating()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
