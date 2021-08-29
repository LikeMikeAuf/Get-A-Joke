//
//  JokeGetter.swift
//  Get a Joke
//
//  Created by Михаил Лоюк on 28.08.2021.
//

import Foundation

protocol JokeGetterProtocol {
    func getJoke(handler: @escaping (String) -> Void)
}

class JokeGetter: JokeGetterProtocol {
    
    func getJoke(handler: @escaping (String) -> Void) {
        let url: URL = URL(string: "https://v2.jokeapi.dev/joke/Any")!
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["AuthToken": "null"]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            print(String(decoding: data!, as: UTF8.self))
//            print(response)
//            print(error)
            if let data = data, let joke = try? JSONDecoder().decode(JokeJSON.self, from: data) {
                let string: String = self.prepareJoke(joke: joke)
                DispatchQueue.main.async {
                    handler(string)
                }
            }
        }
        task.resume()
    }
    
    private func prepareJoke(joke: JokeProtocol) -> String {
        var outputText: String
        if joke.type! == "single" {
            outputText = joke.joke ?? "error"
        } else if joke.type! == "twopart" {
            let setup = joke.setup ?? "error"
            let delivery = joke.delivery ?? "error"
            outputText = setup + "\n\n" + delivery
        } else {
            outputText = "else error"
        }
        return outputText
    }
}
