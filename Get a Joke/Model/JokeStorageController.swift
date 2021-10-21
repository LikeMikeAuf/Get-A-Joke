//
//  JokeStorage.swift
//  Get a Joke
//
//  Created by Михаил Лоюк on 03.10.2021.
//

import Foundation
import CoreData
import UIKit

protocol JokeStorageControllerProtocol {
    
    func saveNewJoke(_ joke: JokeJSON)
    func fetchJokes() -> [JokeStorage]
    
}

class JokeStorageController: JokeStorageControllerProtocol {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchJokes() -> [JokeStorage] {
        
        let jokeFetchRequest = NSFetchRequest<JokeStorage>(entityName: "JokeStorage")
        var jokes: [JokeStorage] = []
        
        jokes = try! context.fetch(jokeFetchRequest)
        jokes.sort(by: {$0.id < $1.id})
        
        return jokes
    }
    
    func saveNewJoke(_ jokeToSave: JokeJSON) {
        
        let requestForExistingFlags = NSFetchRequest<NSManagedObject>(entityName: "FlagsStorage")
        var existingFlags: [NSManagedObject] = []
        
        let requestForExistingJokes = NSFetchRequest<JokeStorage>(entityName: "JokeStorage")
        var existingJokes: [JokeStorage] = []
        
        do {
            existingFlags = try context.fetch(requestForExistingFlags)
            existingJokes = try context.fetch(requestForExistingJokes)
        } catch {
            print("An error occured while fetching data from storage")
        }
        
        for item in existingJokes {
            if item.id == jokeToSave.id! {
                return
            }
        }
        
        //      Creating new Joke instance
        let joke = JokeStorage(context: context)
        
        joke.category = jokeToSave.category
        joke.type = jokeToSave.type
        if jokeToSave.type == "twopart" {
            joke.setup = jokeToSave.setup
            joke.delivery = jokeToSave.delivery
        } else if jokeToSave.type == "single" {
            joke.joke = jokeToSave.joke
        }
        joke.id = Int16(jokeToSave.id!)
        
        //        Checking for existing flags
        for flag in existingFlags {
            
            let castedFlag = flag as! FlagsStorage
            
            if castedFlag.nsfw == jokeToSave.flags!.nsfw,
               castedFlag.political == jokeToSave.flags!.political,
               castedFlag.religious == jokeToSave.flags!.religious,
               castedFlag.racist == jokeToSave.flags!.racist,
               castedFlag.sexist == jokeToSave.flags!.sexist,
               castedFlag.explicit == jokeToSave.flags!.explicit {
                
                castedFlag.addToMatchingJokes(joke)
                joke.flag = castedFlag
                
                do {
                    try context.save()
                } catch {
                    print("An error occured while saving data to storage")
                }
                
                print("Used existing flag set")
                
                break
            }
        }
        
        //        If there's no existing flagset in storage
        if joke.flag == nil {
            
            let flags = FlagsStorage(context: context)
            
            flags.nsfw = jokeToSave.flags!.nsfw!
            flags.political = jokeToSave.flags!.political!
            flags.religious = jokeToSave.flags!.religious!
            flags.racist = jokeToSave.flags!.racist!
            flags.sexist = jokeToSave.flags!.sexist!
            flags.explicit = jokeToSave.flags!.explicit!
            
            flags.addToMatchingJokes(joke)
            joke.flag = flags
            
            do {
                try context.save()
            } catch {
                print("An error occured while saving data to storage")
            }
            
            print("Created new flag set")
        }
    }
}
