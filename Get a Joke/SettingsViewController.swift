//
//  SettingsViewController.swift
//  Get a Joke
//
//  Created by Михаил Лоюк on 30.08.2021.
//

import UIKit

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
        prepareSwitches(settings)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//    }
    
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
}
