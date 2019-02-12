//
//  PlayerDetailController.swift
//  Players
//
//  Created by Gurvinder Singh  on 06/02/19.
//  Copyright © 2019 LazyBaboon. All rights reserved.
//

import UIKit
import PKHUD

class PlayerDetailController: UIViewController {

    @IBOutlet weak var tv_playerDetails: UITableView!
    
    var filter: Filters!
    var arr_Players: Array<Player>! = []
    var userFilters: UserFilters! = UserFilters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        self.getFilters()
        self.getPlayerList(skills: "", categories: "", buildings: "", teamStatus: -1)
    }
    
    @IBAction func filterClicked(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "filters", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filters" {
            let vc = segue.destination as! FilterManager
            vc.filters = filter
            vc.delegate = self
            vc.userFilters = userFilters
        }
    }
    
}


// MARK: Tableview methods
extension PlayerDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_Players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayerDetailCell! = tv_playerDetails.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as? PlayerDetailCell
        cell.selectionStyle = .none
        cell.populateCell(playerDetails: arr_Players[indexPath.row])
        
        return cell
    }
    
}

// MARK: API call methods
extension PlayerDetailController {
    func getFilters() {
        PKHUD.sharedHUD.show()
        APIManager.apiInstance.getData(urlString: Constants.sharedInstance.filters(), params: "", requestType: .GET) {
            (success, reason, data) in
            do {
                self.filter = try JSONDecoder().decode(Filters.self, from: data ?? Data())
            } catch let err {
                print(err)
            }
            DispatchQueue.main.async { PKHUD.sharedHUD.hide(true) }
        }
    }
    
    func getPlayerList(skills: String, categories: String, buildings: String, teamStatus: Int) {
        PKHUD.sharedHUD.show()
        let params = "category=\(categories)&&skill=\(skills)&&building=\(buildings)&&team_status=\(teamStatus)"
        APIManager.apiInstance.getData(urlString: Constants.sharedInstance.playersList(), params: params, requestType: .POST) {
            (success, reason, data) in
            do {
                let asd = try JSONSerialization.jsonObject(with: data ?? Data(), options: .allowFragments)
                let playersData = try JSONDecoder().decode(PlayersData.self, from: data ?? Data())
                self.arr_Players = playersData.data?.players
                self.setColorsForTeams(playerList: self.arr_Players)
                DispatchQueue.main.async { self.tv_playerDetails.reloadData() }
            }
            catch let err {
                print(err)
            }
            DispatchQueue.main.async { PKHUD.sharedHUD.hide(true) }
        }
    }
}

// MARK: Setting UI & colors for different teams
extension PlayerDetailController {
    
    func setUIElements() {
        self.tv_playerDetails.tableFooterView = UIView()
        self.tv_playerDetails.separatorStyle = .none
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 122.0/255, green: 142.0/255, blue: 49.0/255, alpha: 1.0)
        self.title = "PLAYERS"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
}
    
    func setColorsForTeams(playerList: Array<Player>) {
        playerList.forEach { (player) in
            if CommonFunctions.sharedInstance.dictDynamicColorList?[player.team ?? ""] == nil
            {
                CommonFunctions.sharedInstance.dictDynamicColorList?.updateValue(CommonFunctions.sharedInstance.generateRandomColor(), forKey: player.team ?? "")
            }
        }
    }
    
}

extension PlayerDetailController: ApplyFilters {
    func filterPlayersWith(userFilters: UserFilters) {
        self.resetTable()
        self.userFilters = userFilters
        self.getPlayerList (
            skills: self.getCommaSeparatedValuesFromArray(inputArray: userFilters.skills ?? []),
            categories: self.getCommaSeparatedValuesFromArray(inputArray: userFilters.categories ?? []),
            buildings: self.getCommaSeparatedValuesFromArray(inputArray: userFilters.buildings ?? []),
            teamStatus: userFilters.teamStatus ?? -1
        )
    }
    
    
    func resetTable() {
        self.arr_Players = []
        self.tv_playerDetails.reloadData()
    }
    
    func getCommaSeparatedValuesFromArray(inputArray: [Int]) -> String {
        var commaSeparatedString = ""
        inputArray.forEach { (value) in
            commaSeparatedString = (commaSeparatedString == "") ? commaSeparatedString + "\(value)" : commaSeparatedString + ",\(value)"
        }
        return commaSeparatedString
    }
}
