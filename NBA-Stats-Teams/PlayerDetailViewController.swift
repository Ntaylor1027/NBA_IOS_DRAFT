//
//  PlayerDetailViewController.swift
//  NBA-Stats-Teams
//
//  Created by Noah Taylor on 4/30/20.
//  Copyright © 2020 Noah Taylor. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var assitsLabel: UILabel!
    @IBOutlet weak var reboundsLabel: UILabel!
    @IBOutlet weak var fieldgoalLabel: UILabel!
    @IBOutlet weak var fieldgoal3Label: UILabel!
    @IBOutlet weak var draftButton: UIButton!
    
    
    var playerNameValue: String?;
    var playerImageValue: String?;
    var teamImageValue: String?;
    var positionValue: String?;
    var ageValue: String?;
    var pointsValue: String?;
    var assistValue: String?;
    var reboundValue: String?;
    var fieldgoalValue: String?;
    var fieldgoal3Value: String?;
    
    var playerToDraft: Player?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageLabel.text = ageValue!;
        assitsLabel.text = assistValue!;
        fieldgoal3Label.text = fieldgoal3Value;
        fieldgoalLabel.text = fieldgoalValue;
        playerNameLabel.text = playerNameValue;
        pointsLabel.text = pointsValue;
        positionLabel.text = positionValue;
        reboundsLabel.text = reboundValue;
        teamImage.image = UIImage(named: teamImageValue!);
        playerImage.image = UIImage(named: playerImageValue!);
        
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "fromPlayerDetailToDraftSelection"){
            let draftVC = segue.destination as! DraftTableViewController
            draftVC.playerToDraft = playerToDraft;
        }
    }
    
    
}
