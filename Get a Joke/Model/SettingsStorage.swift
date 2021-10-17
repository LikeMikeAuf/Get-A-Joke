//
//  SettingsStorage.swift
//  Get a Joke
//
//  Created by Михаил Лоюк on 31.08.2021.
//

import Foundation

protocol SettingsStorageProtocol {
    func getSetteings() -> [String: Bool]
    func saveSettings(_ settings: [String:Bool])
}

class SettingsStorage: SettingsStorageProtocol {
    
    var userDefaults = UserDefaults.standard
    let userDefaultsFlagsKey: String = "Flags To Blacklist"
    
    func getSetteings() -> [String: Bool] {
        let flagsToBlacklist = userDefaults.object(forKey: userDefaultsFlagsKey) as? [String: Bool] ?? ["": true]
        return flagsToBlacklist
    }
    
    func saveSettings(_ settings: [String: Bool]) {
        userDefaults.set(settings, forKey: userDefaultsFlagsKey)
    }
}
