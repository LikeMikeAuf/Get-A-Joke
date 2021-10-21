//
//  SavedJokesViewController.swift
//  Get a Joke
//
//  Created by Михаил Лоюк on 03.10.2021.
//

import UIKit

class SavedJokesViewController: UITableViewController {
    
    let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)
    
    let jokeStorage = JokeStorageController()
    var jokesToShow: [JokeStorage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.jokesToShow = jokeStorage.fetchJokes()
        print("Jokes To Show = \(jokesToShow.count)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if jokesToShow.count == 0 {
            return 1
        }

        return jokesToShow.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedJoke", for: indexPath)
        
        if jokesToShow.count == 0 {
            
            cell.textLabel?.text = "There are no jokes in local storage"
            cell.accessoryType = .none
            cell.isUserInteractionEnabled = false
            return cell
        }

        cell.textLabel?.text = String(jokesToShow[indexPath.row].id)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let jokeView = storyboard!.instantiateViewController(identifier: "JokePresent") as JokePresentViewController
        jokeView.joke = translateToSavedJoke(jokesToShow[indexPath.row])
        self.navigationController?.pushViewController(jokeView, animated: true)
    }
    
    private func translateToSavedJoke(_ jokeStorage: JokeStorage) -> SavedJoke {
        
        let flags = Flags(nsfw: jokeStorage.flag?.nsfw,
                          religious: jokeStorage.flag?.religious,
                          political: jokeStorage.flag?.political,
                          racist: jokeStorage.flag?.racist,
                          sexist: jokeStorage.flag?.sexist,
                          explicit: jokeStorage.flag?.explicit)
        
        let joke = SavedJoke(category: jokeStorage.category,
                             setup: jokeStorage.setup,
                             delivery: jokeStorage.delivery, joke: jokeStorage.joke,
                             type: jokeStorage.type,
                             id: Int(jokeStorage.id),
                             flags: flags)
        return joke
    }
}
