//
//  SettingsViewController.swift
//  Get a Joke
//
//  Created by Михаил Лоюк on 30.08.2021.
//

import UIKit
import CoreData

class SettingsViewController: UITableViewController {
    
    var settings: [String: Bool]!
    var settingsStorage: SettingsStorageProtocol!
    
    @IBOutlet var nsfwSwitch: UISwitch!
    @IBOutlet var religiousSwitch: UISwitch!
    @IBOutlet var politicalSwitch: UISwitch!
    @IBOutlet var racistSwitch: UISwitch!
    @IBOutlet var sexistSwitch: UISwitch!
    @IBOutlet var explicitSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        prepareSwitches(settings)
    }
    
    @IBAction func doneButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        switchesToSettings()
        settingsStorage.saveSettings(settings)
    }
    
    private func prepareSwitches(_ settings: [String: Bool]) {
        nsfwSwitch.isOn = settings["nsfw"] ?? true
        religiousSwitch.isOn = settings["religious"] ?? true
        politicalSwitch.isOn = settings["political"] ?? true
        racistSwitch.isOn = settings["racist"] ?? true
        sexistSwitch.isOn = settings["sexist"] ?? true
        explicitSwitch.isOn = settings["explicit"] ?? true
    }
    
    private func switchesToSettings() {
        settings["nsfw"] = nsfwSwitch.isOn
        settings["religious"] = religiousSwitch.isOn
        settings["political"] = politicalSwitch.isOn
        settings["racist"] = racistSwitch.isOn
        settings["sexist"] = sexistSwitch.isOn
        settings["explicit"] = explicitSwitch.isOn
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1, indexPath.row == 0 {
            showClearStoragaAlert()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func showClearStoragaAlert() {
        
        let alert = UIAlertController(title: "Are you sure to clear Joke storage?", message: "This action cannot be undone", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action: UIAlertAction!) in
            self.clearJokesStorage()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func clearJokesStorage() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "JokeStorage")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("An error occured while deliting jokes")
        }
    }
}
