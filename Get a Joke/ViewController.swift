//
//  ViewController.swift
//  Get a Joke
//
//  Created by Михаил Лоюк on 28.08.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var textField: UITextView!
    
    let jokeGetter = JokeGetter()
    var settingsStorage = SettingsStorage()
    
    @IBAction func showJoke(_ sender: UIButton) {
        jokeGetter.getJoke(settingsStorage.getSetteings()) { [unowned self] text in
            textField.text = text
        }
    }
    
    @IBAction func showSettingsScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(identifier: "NavigationController") as UINavigationController
        let settingsScreen = navigationController.viewControllers.first as! SettingsViewController
        settingsScreen.settings = settingsStorage.getSetteings()
        settingsScreen.settingsStorage = settingsStorage
        self.present(navigationController, animated: true, completion: nil)
    }
}
