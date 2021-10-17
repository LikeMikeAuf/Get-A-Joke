//
//  JokePresentViewController.swift
//  Get a Joke
//
//  Created by Михаил Лоюк on 17.10.2021.
//

import UIKit

class JokePresentViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var categoryLabel: UILabel!
    
    var joke: SavedJoke!
    
    var flags: [(name: String, bool: Bool)]!
    
    private func cleanFlags(_ flags: [(name: String, bool: Bool)]) -> [(name: String, bool: Bool)] {
        var cleanedFlags = flags
        var count = 0
        var toRemove: [Int] = []
        for flag in flags {
            if !flag.bool {
                toRemove.append(count)
            }
            count += 1
        }
        toRemove.sort(by: {$1 < $0})
        for i in toRemove {
            cleanedFlags.remove(at: i)
        }
        return cleanedFlags
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Joke #\(joke.id!)"
        
        categoryLabel.text = joke.category
        
        if joke.type == "single" {
            textView.text = joke.joke
        } else {
            textView.text = joke.setup! + "\n\n" + joke.delivery!
        }
        
        let flagsToClean = [
            ("NSFW", joke.flags!.nsfw!),
            ("Political", joke.flags!.political!),
            ("Religious", joke.flags!.religious!),
            ("Racist", joke.flags!.racist!),
            ("Sexist", joke.flags!.sexist!),
            ("Explicit", joke.flags!.explicit!)
        ]
         flags = cleanFlags(flagsToClean)
        
    }
}

extension JokePresentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if flags.count == 0 {
            return 1
        } else {
            return flags.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flagCell", for: indexPath) as! FlagsCollectionViewCell
        if flags.count == 0 {
            cell.flagLabel.text = "No flags"
        } else {
            cell.flagLabel.text = flags[indexPath.row].name
        }
        return cell
    }
    
}
