//
//  Filters.swift
//  Players
//
//  Created by Gurvinder Singh  on 10/02/19.
//  Copyright © 2019 LazyBaboon. All rights reserved.
//

import UIKit

protocol ApplyFilters {
    func filterPlayersWith(skills: [Int], categories: [Int], buildings: [Int], teamStatus: Int)
}

class FilterManager: UIViewController {
    
    @IBOutlet weak var sv_BackgroundScroll: UIScrollView!
    @IBOutlet weak var btn_Apply: UIButton!
    
    var filters: Filters!
    var currentY: CGFloat = 10.0
    
    var arrCategories: [Int] = []
    var arrSkills: [Int] = []
    var arrBuildings: [Int] = []
    var int_teamStatus: Int = -1
    
    var delegate: ApplyFilters?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateApplyStatus()
        self.createAndSetAllFilters()
        self.sv_BackgroundScroll.contentSize = CGSize(width: self.sv_BackgroundScroll.frame.size.width, height: currentY+100)
    }
    
    @IBAction func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func applyFilters(_ sender: Any) {
        delegate?.filterPlayersWith(skills: arrSkills, categories: arrCategories, buildings: arrBuildings, teamStatus: int_teamStatus)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

// MARK: Setting and Creating filters for various FilterTypes
extension FilterManager {
    
    func createAndSetAllFilters() {
        self.setBuildingFilters()
        self.setCategoryFilters()
//        self.setPoinFilters()
        self.setSkillFilters()
        self.setTeamStatusFilters()
    }
    
    func setBuildingFilters() {
        self.sv_BackgroundScroll.addSubview(self.createLabelsForFilterTypes(title: CheckBoxType.Building.value()))
        self.filters.data?.buildings?.forEach({ (buildingFilterObj) in
            let tag = buildingFilterObj.id ?? 0
            let checkBox = self.createCheckBoxWith(tag: tag, title: buildingFilterObj.name ?? "", checkBoxType: .Building)
            self.sv_BackgroundScroll.addSubview(checkBox)
        })
    }
    
    func setCategoryFilters() {
        self.sv_BackgroundScroll.addSubview(self.createLabelsForFilterTypes(title: CheckBoxType.Category.value()))
        self.filters.data?.categories?.forEach({ (categoryFilterObj) in
            let tag = categoryFilterObj.id ?? 0
            let checkBox = self.createCheckBoxWith(tag: tag, title: categoryFilterObj.name ?? "", checkBoxType: .Category)
            self.sv_BackgroundScroll.addSubview(checkBox)
        })
    }
    
    func setPoinFilters() {
        self.sv_BackgroundScroll.addSubview(self.createLabelsForFilterTypes(title: CheckBoxType.Point.value()))
        self.filters.data?.points?.forEach({ (pointFilterObj) in
            let tag = pointFilterObj.id ?? 0
            let checkBox = self.createCheckBoxWith(tag: tag, title: pointFilterObj.name ?? "", checkBoxType: .Point)
            self.sv_BackgroundScroll.addSubview(checkBox)
        })

    }

    func setSkillFilters() {
        self.sv_BackgroundScroll.addSubview(self.createLabelsForFilterTypes(title: CheckBoxType.Skill.value()))
        self.filters.data?.skills?.forEach({ (skillFilterObj) in
            let tag = skillFilterObj.id ?? 0
            let checkBox = self.createCheckBoxWith(tag: tag, title: skillFilterObj.name ?? "", checkBoxType: .Skill)
            self.sv_BackgroundScroll.addSubview(checkBox)
        })
    }
    
    func setTeamStatusFilters() {
        self.sv_BackgroundScroll.addSubview(self.createLabelsForFilterTypes(title: CheckBoxType.TeamStatus.value()))
        self.filters.data?.teamStatus?.forEach({ (teamStatusFilterObj) in
            let tag = teamStatusFilterObj.id ?? 0
            let checkBox = self.createCheckBoxWith(tag: tag, title: teamStatusFilterObj.name ?? "", checkBoxType: .TeamStatus)
            self.sv_BackgroundScroll.addSubview(checkBox)
        })
    }
    
}


// MARK: Dynamic Checkbox, it's delegates and Dynamic Label methods
extension FilterManager: CheckBoxDelegate {
    
    func createLabelsForFilterTypes(title: String) -> UILabel {
        let filterLabel = UILabel(frame: CGRect(x: 20, y: currentY, width: 200, height: 30))
        filterLabel.text = title
        filterLabel.font = UIFont.systemFont(ofSize: 16.0)
        filterLabel.textColor = UIColor.black
        currentY = currentY + 40
        return filterLabel
    }
    
    func createCheckBoxWith(tag: Int, title: String, checkBoxType: CheckBoxType) -> CheckBox
    {
        let checkBox = CheckBox(frame: CGRect(x: 40, y: currentY, width: 250, height: 25))
        checkBox.delegate = self
        checkBox.tag = tag
        checkBox.checkBoxType = checkBoxType
        checkBox.checkBoxTitle = title
        checkBox.fontSize = 14
        checkBox.isUserInteractionEnabled = true
        currentY = currentY + 30
        return checkBox
    }

    func checkBoxClicked(_ checkBox: CheckBox) {
        switch checkBox.checkBoxType! {
            case .Building:
                arrBuildings = self.updateArray(inputArray: arrBuildings, valueToRemoveOrAppend: checkBox.tag, status: checkBox.checked!)
                break
            case .Category:
                arrCategories = self.updateArray(inputArray: arrCategories, valueToRemoveOrAppend: checkBox.tag, status: checkBox.checked!)
                break
            case .Skill:
                arrSkills = self.updateArray(inputArray: arrSkills, valueToRemoveOrAppend: checkBox.tag, status: checkBox.checked!)
                break
            case .TeamStatus:
                int_teamStatus = checkBox.tag
                break
            default:
                break
        }
        self.updateApplyStatus()
    }
    
    func updateApplyStatus() {
        if arrBuildings.count == 0 && arrCategories.count == 0 && arrSkills.count == 0 && int_teamStatus < 0 {
            self.btn_Apply.isEnabled = false
            self.btn_Apply.alpha = 0.5
        }
        else {
            self.btn_Apply.isEnabled = true
            self.btn_Apply.alpha = 1
        }
    }
    
    func updateArray(inputArray: [Int], valueToRemoveOrAppend: Int, status: Bool) -> [Int] {
        if status {
            var updatedArray = inputArray
            updatedArray.append(valueToRemoveOrAppend)
            return updatedArray
        } else {
            let filteredArray = inputArray.filter { (value) -> Bool in
                value != valueToRemoveOrAppend
            }
            return filteredArray
        }
    }
    
    
}



