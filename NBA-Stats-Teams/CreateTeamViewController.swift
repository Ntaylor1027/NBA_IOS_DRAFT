//
//  CreateTeamViewController.swift
//  NBA-Stats-Teams
//
//  Created by Noah Taylor on 4/30/20.
//  Copyright © 2020 Noah Taylor. All rights reserved.
//

import UIKit

class CreateTeamViewController: UIViewController {

    var teamName: String = "";
    var teamCreator: String = "";
    
   
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var teamCreatorTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
