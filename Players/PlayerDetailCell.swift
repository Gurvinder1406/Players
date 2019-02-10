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
    
    
    func populateCell(playerDetails: Player) {
        
    }
    
    
}
