//
//  JokeGetter.swift
//  Get a Joke
//
//  Created by Михаил Лоюк on 28.08.2021.
//

import Foundation

protocol JokeGetterProtocol {
    func getJoke(_ settings: [String: Bool], handler: @escaping (String) -> Void)
}

class JokeGetter: JokeGetterProtocol {
    
    func getJoke(_ settings: [String: Bool], handler: @escaping (String) -> Void) {
        let url: URL = prepareURL(settings)
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["AuthToken": "null"]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            print(String(decoding: data!, as: UTF8.self))
//            print(response)
//            print(error)
            if let data = data, let joke = try? JSONDecoder().decode(JokeJSON.self, from: data) {
//                print(String(decoding: data, as: UTF8.self))
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
    
    private func prepareURL(_ settings: [String: Bool]) -> URL {
        let baseURL: String = "https://v2.jokeapi.dev/joke"
        var parametersURL: String = ""
        let values = Array(settings.values)
        var any: Bool = true
        values.forEach { value in
            if value == false {
                any = false
            }
        }
        if any == true {
            parametersURL = "/Any"
        } else {
            if settings["nsfw"] == false {
                if parametersURL == "" {
                    parametersURL = "/Any?blacklistFlags=nsfw"
                } else {
                    parametersURL += ",nsfw"
                }
            }
            if settings["religious"] == false {
                if parametersURL == "" {
                    parametersURL = "/Any?blacklistFlags=religious"
                } else {
                    parametersURL += ",religious"
                }
            }
            if settings["political"] == false {
                if parametersURL == "" {
                    parametersURL = "/Any?blacklistFlags=political"
                } else {
                    parametersURL += ",political"
                }
            }
            if settings["racist"] == false {
                if parametersURL == "" {
                    parametersURL = "/Any?blacklistFlags=racist"
                } else {
                    parametersURL += ",racist"
                }
            }
            if settings["sexist"] == false {
                if parametersURL == "" {
                    parametersURL = "/Any?blacklistFlags=sexist"
                } else {
                    parametersURL += ",sexist"
                }
            }
            if settings["explicit"] == false {
                if parametersURL == "" {
                    parametersURL = "/Any?blacklistFlags=explicit"
                } else {
                    parametersURL += ",explicit"
                }
            }
        }
        let url = baseURL + parametersURL
        print(url)
        return URL(string: url) ?? URL(string: "")!
    }
}
