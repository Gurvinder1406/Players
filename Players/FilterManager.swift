//
//  Filters.swift
//  Players
//
//  Created by Gurvinder Singh  on 10/02/19.
//  Copyright © 2019 LazyBaboon. All rights reserved.
//

import UIKit

protocol ApplyFilters {
    func filterPlayersWith(userFilters: UserFilters)
}

class FilterManager: UIViewController {
    
    @IBOutlet weak var sv_BackgroundScroll: UIScrollView!
    @IBOutlet weak var btn_Apply: UIButton!
    
    var filters: Filters!
    var currentY: CGFloat = 10.0
    var userFilters: UserFilters = UserFilters()
    var delegate: ApplyFilters?
    var arrCheckBoxes: [CheckBox] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyFilters(self)
        self.createAndSetAllFilters()
        self.sv_BackgroundScroll.contentSize = CGSize(width: self.sv_BackgroundScroll.frame.size.width, height: currentY+100)
    }
    
    @IBAction func back(sender: UIButton) {
        self.applyFilters(self)
    }

    @IBAction func applyFilters(_ sender: Any) {
        delegate?.filterPlayersWith(userFilters: self.userFilters)
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
            let checkBox = self.createCheckBoxWith(tag: tag, title: buildingFilterObj.name ?? "", checkBoxType: .Building, setChecked: userFilters.buildings?.contains(tag) ?? false)
            arrCheckBoxes.append(checkBox)
            self.sv_BackgroundScroll.addSubview(checkBox)
        })
    }
    
    func setCategoryFilters() {
        self.sv_BackgroundScroll.addSubview(self.createLabelsForFilterTypes(title: CheckBoxType.Category.value()))
        self.filters.data?.categories?.forEach({ (categoryFilterObj) in
            let tag = categoryFilterObj.id ?? 0
            let checkBox = self.createCheckBoxWith(tag: tag, title: categoryFilterObj.name ?? "", checkBoxType: .Category, setChecked: userFilters.categories?.contains(tag) ?? false)
            arrCheckBoxes.append(checkBox)
            self.sv_BackgroundScroll.addSubview(checkBox)
        })
    }
    
    func setPoinFilters() {
        self.sv_BackgroundScroll.addSubview(self.createLabelsForFilterTypes(title: CheckBoxType.Point.value()))
        self.filters.data?.points?.forEach({ (pointFilterObj) in
            let tag = pointFilterObj.id ?? 0
            let checkBox = self.createCheckBoxWith(tag: tag, title: pointFilterObj.name ?? "", checkBoxType: .Point, setChecked: false)
//            if userFilters?.contains(tag) ?? false { checkBox.checked = true }
            arrCheckBoxes.append(checkBox)
            self.sv_BackgroundScroll.addSubview(checkBox)
        })

    }

    func setSkillFilters() {
        self.sv_BackgroundScroll.addSubview(self.createLabelsForFilterTypes(title: CheckBoxType.Skill.value()))
        self.filters.data?.skills?.forEach({ (skillFilterObj) in
            let tag = skillFilterObj.id ?? 0
            let checkBox = self.createCheckBoxWith(tag: tag, title: skillFilterObj.name ?? "", checkBoxType: .Skill, setChecked: userFilters.skills?.contains(tag) ?? false)
            arrCheckBoxes.append(checkBox)
            self.sv_BackgroundScroll.addSubview(checkBox)
        })
    }
    
    func setTeamStatusFilters() {
        self.sv_BackgroundScroll.addSubview(self.createLabelsForFilterTypes(title: CheckBoxType.TeamStatus.value()))
        self.filters.data?.teamStatus?.forEach({ (teamStatusFilterObj) in
            let tag = teamStatusFilterObj.id ?? 0
            let checkBox = self.createCheckBoxWith(tag: tag, title: teamStatusFilterObj.name ?? "", checkBoxType: .TeamStatus, setChecked: userFilters.teamStatus == tag)
            arrCheckBoxes.append(checkBox)
            self.sv_BackgroundScroll.addSubview(checkBox)
        })
    }
    
    func resetCheckBoxStatus() {
        arrCheckBoxes.forEach { (singleCheckBox) in
            singleCheckBox.checked = true
            singleCheckBox.ChangeStatus(singleCheckBox.checkBoxButton)
        }
    }
    
    @IBAction func resetFilters() {
        self.userFilters = UserFilters()
        self.resetCheckBoxStatus()
        self.updateApplyStatus()
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
    
    func createCheckBoxWith(tag: Int, title: String, checkBoxType: CheckBoxType, setChecked: Bool) -> CheckBox
    {
        let checkBox = CheckBox(frame: CGRect(x: 40, y: currentY, width: 250, height: 25))
        checkBox.delegate = self
        checkBox.tag = tag
        checkBox.checkBoxType = checkBoxType
        checkBox.checkBoxTitle = title
        checkBox.fontSize = 14
        checkBox.isUserInteractionEnabled = true
        if setChecked { checkBox.ChangeStatus(checkBox.checkBoxButton) }
        currentY = currentY + 30
        return checkBox
    }

    func checkBoxClicked(_ checkBox: CheckBox) {
        switch checkBox.checkBoxType! {
            case .Building:
                userFilters.buildings = self.updateArray(inputArray: userFilters.buildings ?? [], valueToRemoveOrAppend: checkBox.tag, status: checkBox.checked!)
                break
            case .Category:
                userFilters.categories = self.updateArray(inputArray: userFilters.categories ?? [], valueToRemoveOrAppend: checkBox.tag, status: checkBox.checked!)
                break
            case .Skill:
                userFilters.skills = self.updateArray(inputArray: userFilters.skills ?? [], valueToRemoveOrAppend: checkBox.tag, status: checkBox.checked!)
                break
            case .TeamStatus:
                if checkBox.checked { userFilters.teamStatus = checkBox.tag }
                else { userFilters.teamStatus = -1 }
                break
            default:
                break
        }
        self.updateApplyStatus()
    }
    
    func updateApplyStatus() {
        if userFilters.buildings?.count == 0 && userFilters.categories?.count == 0 && userFilters.skills?.count == 0 && userFilters.teamStatus ?? -1 < 0 {
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



