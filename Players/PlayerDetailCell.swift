//
//  PlayerDetailCell.swift
//  Players
//
//  Created by Gurvinder Singh  on 10/02/19.
//  Copyright © 2019 LazyBaboon. All rights reserved.
//

import UIKit

class PlayerDetailCell: UITableViewCell {

    @IBOutlet weak var v_upperView: UIView!
    @IBOutlet weak var v_separator: UIView!
    @IBOutlet weak var v_lowerView: UIView!
    
    @IBOutlet weak var lbl_teamColor: UILabel!
    @IBOutlet weak var lbl_categoryName: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var iv_userImage: UIImageView!
    @IBOutlet weak var lbl_nameAge: UILabel!
    @IBOutlet weak var lbl_teamName: UILabel!
    @IBOutlet weak var lbl_skills: UILabel!
    
    @IBOutlet weak var lbl_id: UILabel!
    @IBOutlet weak var lbl_points: UILabel!
    @IBOutlet weak var lbl_building: UILabel!
    @IBOutlet weak var v_mainBackground: UIView!
    @IBOutlet weak var lbl_lowerTeamColor: UILabel!
    
    
    override func awakeFromNib() {
        v_mainBackground.layer.cornerRadius = 10
        iv_userImage.layer.cornerRadius = iv_userImage.frame.height/2
    }
    
    func populateCell(playerDetails: Player) {
        
        lbl_categoryName.text = playerDetails.category ?? ""
        lbl_price.text = "Price:  ₹\(playerDetails.basePrice ?? "")"
        lbl_nameAge.text = "\(playerDetails.name ?? "") (\(playerDetails.age ?? 0) yrs)"
        lbl_teamName.text = playerDetails.team ?? ""
        lbl_skills.text = self.setSkills(playerDetails: playerDetails)
        lbl_id.text = "\(playerDetails.id ?? 0)"
        lbl_points.text = "\(playerDetails.points ?? 0)"
        lbl_building.text = playerDetails.building ?? ""
        iv_userImage.image = UIImage(named: "player")
        self.setTeamColor(color: CommonFunctions.sharedInstance.dictDynamicColorList[playerDetails.team ?? ""] ?? UIColor())
    }
    
    
    func setSkills(playerDetails: Player) -> String {
        
        var skillBuilder: String = ""
        if (playerDetails.batsman ?? "").replacingOccurrences(of: "-", with: "") != "" {
            skillBuilder = skillBuilder + "\(playerDetails.batsman ?? "") batsman"
        }
        if (playerDetails.bowler ?? "").replacingOccurrences(of: "-", with: "") != "" {
            if skillBuilder != "" {
                skillBuilder = skillBuilder + ", "
            }
            skillBuilder = skillBuilder + "\(playerDetails.bowler ?? "") bowler"
        }
        if skillBuilder == "" {
            skillBuilder = "-"
        }
        
        return skillBuilder
    }
    
    func setTeamColor(color: UIColor) {
        lbl_teamColor.backgroundColor = color
        v_separator.backgroundColor = color
        lbl_lowerTeamColor.backgroundColor = color
    }
    
}
