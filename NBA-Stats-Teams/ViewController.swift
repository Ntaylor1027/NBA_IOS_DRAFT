//
//  ViewController.swift
//  NBA-Stats-Teams
//
//  Created by Noah Taylor on 4/27/20.
//  Copyright © 2020 Noah Taylor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var nbaLogo: UIImageView!
    @IBOutlet weak var searchPlayersButton: UIButton!
    @IBOutlet weak var viewTeamsButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nbaLogo.image = UIImage(named: "nbalogo.png");
    }


}

