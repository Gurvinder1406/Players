//
//  PlayerDetailController.swift
//  Players
//
//  Created by Gurvinder Singh  on 06/02/19.
//  Copyright © 2019 LazyBaboon. All rights reserved.
//

import UIKit

class PlayerDetailController: UIViewController {

    @IBOutlet weak var tv_playerDetails: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    



}


extension PlayerDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
