//
//  Joke.swift
//  Get a Joke
//
//  Created by Михаил Лоюк on 28.08.2021.
//

import Foundation

//enum JokeType {
//    case single
//    case twopart
//}

protocol JokeProtocol {
    var type: String? { get set }
    var joke: String? { get set }
    var setup: String? { get set }
    var delivery: String? { get set }
}

struct Joke: JokeProtocol {
    var type: String?
    var joke: String?
    var setup: String?
    var delivery: String?
}

struct JokeJSON: Codable, JokeProtocol {
    var error: Bool?
    var category, setup, delivery, joke: String?
    var type: String?
    var flags: Flags?
    var id: Int?
    var safe: Bool?
    var lang: String?
}

struct Flags: Codable {
    var nsfw, religious, political, racist: Bool?
    var sexist, explicit: Bool?
}