//
//  Players.swift
//  Players
//
//  Created by Gurvinder Singh  on 09/02/19.
//  Copyright © 2019 LazyBaboon. All rights reserved.
//

import UIKit

class PlayersData: Codable {
    var data: Players?
    var msg: String?
    var success: Bool?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        data = try container.decode(Players?.self, forKey: .data)
        msg = try container.decode(String?.self, forKey: .msg)
        success = try container.decode(Bool?.self, forKey: .success)
    }
    
    enum Keys: String, CodingKey {
        case data
        case msg
        case success
    }
}

class Players: Codable {
    var players: Array<Player>?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        players = try container.decode(Array<Player>?.self, forKey: .players)
    }
    
    enum Keys: String, CodingKey {
        case players
    }
    
}

class Player: Codable {
    var age: Int?
    var basePrice: String?
    var batsman: String?
    var bowler: String?
    var building: String?
    var category: String?
    var name: String?
    var picture: String?
    var id: Int?
    var points: Int?
    var pointsType: String?
    var team: String?
    var teamStatus: Int?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        age = try container.decode(Int?.self, forKey: .age)
        basePrice = try container.decode(String?.self, forKey: .basePrice)
        batsman = try container.decode(String?.self, forKey: .batsman)
        bowler = try container.decode(String?.self, forKey: .bowler)
        building = try container.decode(String?.self, forKey: .building)
        category = try container.decode(String?.self, forKey: .category)
        name = try container.decode(String?.self, forKey: .name)
        picture = try container.decode(String?.self, forKey: .picture)
        id = try container.decode(Int?.self, forKey: .id)
        points = try container.decode(Int?.self, forKey: .points)
        pointsType = try container.decode(String?.self, forKey: .pointsType)
        team = try container.decode(String?.self, forKey: .team)
        teamStatus = try container.decode(Int?.self, forKey: .teamStatus)
    }
    
    enum Keys: String, CodingKey {
        case age
        case basePrice = "base_price"
        case batsman
        case bowler
        case building
        case category = "category_name"
        case name
        case picture
        case id = "player_id"
        case points
        case pointsType = "points_type"
        case team
        case teamStatus = "team_status"
    }
    
}
