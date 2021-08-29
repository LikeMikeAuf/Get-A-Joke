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
    
    @IBOutlet var textField: UILabel!
    
    let jokeGetter = JokeGetter()
    
    @IBAction func showJoke(_ sender: UIButton) {
        jokeGetter.getJoke() { [unowned self] text in
            textField.text = text
        }
    }
    
    func printJoke(text: String) {
        self.textField.text = text
    }
}



