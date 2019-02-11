//
//  Filters.swift
//  Players
//
//  Created by Gurvinder Singh  on 09/02/19.
//  Copyright © 2019 LazyBaboon. All rights reserved.
//

import UIKit

class Filters: Codable {

    var data: FilterTypes?
    var msg: String?
    var success: Bool?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        data = try container.decode(FilterTypes?.self, forKey: .data)
        msg = try container.decode(String?.self, forKey: .msg)
        success = try container.decode(Bool?.self, forKey: .success)
    }
    
    enum Keys: String, CodingKey {
        case data
        case msg
        case success
    }
    
}

class FilterTypes: Codable {
    var buildings: Array<FilterObject>!
    var categories: Array<FilterObject>?
    var points: Array<FilterObject>?
    var skills: Array<FilterObject>?
    var teamStatus: Array<FilterObject>?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        buildings = try container.decode(Array<FilterObject>?.self, forKey: .buildings)
        categories = try container.decode(Array<FilterObject>?.self, forKey: .categories)
        points = try container.decode(Array<FilterObject>?.self, forKey: .points)
        skills = try container.decode(Array<FilterObject>?.self, forKey: .skills)
        teamStatus = try container.decode(Array<FilterObject>?.self, forKey: .teamStatus)
    }
    
    enum Keys: String, CodingKey {
        case buildings
        case categories
        case points
        case skills
        case teamStatus = "team_status"
    }
    
}

class FilterObject: Codable {
    var id: Int?
    var name: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        id = try container.decode(Int?.self, forKey: .id)
        name = try container.decode(String?.self, forKey: .name)
    }
    
    enum Keys: String, CodingKey {
        case id
        case name
    }
}

class UserFilters {
    
    var buildings: [Int]? = []
    var categories: [Int]? = []
    var skills: [Int]? = []
    var teamStatus: Int? = -1
    
}
