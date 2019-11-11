//
//  StartViewController.swift
//  XO-game
//
//  Created by Iv on 11.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let vc = segue.destination as? GameViewController else { return }
        vc.withComputer = segue.identifier == "segueWithComputer"
    }

}
