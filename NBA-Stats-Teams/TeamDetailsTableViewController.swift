//
//  TeamDetailsTableViewController.swift
//  NBA-Stats-Teams
//
//  Created by Noah Taylor on 5/1/20.
//  Copyright © 2020 Noah Taylor. All rights reserved.
//

import UIKit

class TeamDetailsTableViewController: UITableViewController {

    // MARK: UI Components
    @IBOutlet weak var teamTitleLabel: UILabel!
    @IBOutlet weak var teamCreatorLabel: UILabel!
    @IBOutlet weak var pgNameLabel: UILabel!
    @IBOutlet weak var pgImageView: UIImageView!
    @IBOutlet weak var pgTeamImageView: UIImageView!
    @IBOutlet weak var sgNameLabel: UILabel!
    @IBOutlet weak var sgImageView: UIImageView!
    @IBOutlet weak var sgTeamImageView: UIImageView!
    @IBOutlet weak var sfNameLabel: UILabel!
    @IBOutlet weak var sfImageView: UIImageView!
    @IBOutlet weak var sfTeamImageView: UIImageView!
    @IBOutlet weak var pfNameLabel: UILabel!
    @IBOutlet weak var pfImageView: UIImageView!
    @IBOutlet weak var pfTeamImageView: UIImageView!
    @IBOutlet weak var cNameLabel: UILabel!
    @IBOutlet weak var cImageView: UIImageView!
    @IBOutlet weak var cTeamImageView: UIImageView!
    @IBOutlet weak var totalPointsLabel: UILabel!
    @IBOutlet weak var totalAssistsLabel: UILabel!
    @IBOutlet weak var totalReboundsLabel: UILabel!
    @IBOutlet weak var averageFieldGoalLabel: UILabel!
    @IBOutlet weak var averageFieldGoal3Label: UILabel!
    @IBOutlet weak var averageAgeLabel: UILabel!
    
    
    
    // MARK: Cache Variables
    private var teamToImage: [String: String] = ["POR":"portland_trail_blazers.png", "CHO": "charlotte_hornets.png", "BOS":"boston_celtics.png", "ORL": "orlando_magic.png", "NYK":"new_york_knicks.png", "CLE":"cleveland_cavaliers.png", "PHI":"philadelphia_76s.png", "OKC": "okc_thunder.png", "SAC":"sacramento_kings.png", "SAS":"san_antonio_spurs.jpg", "CHI": "chicago_bulls.png", "DAL": "dallas_mavericks.jpg", "LAL":"la_lakers.png", "PHO": "phoenix_suns.png", "LAC":"la_clippers.png", "WAS":"washington_wizards.png", "DEN":"denver_nuggets.png", "ATL": "atlanta_hawks.png", "MIN": "minnesota_timberwolves.png", "MIA": "miami_heat.png","UTA":"utah_jazz.png", "DET":"detroit-pistons.png", "BRK": "brooklyn_nets.jpg", "HOU":"houston_rockets.png", "NOP":"new_orleans_pelicans.png", "MEM":"memphis_grizzlies.jpeg", "GSW":"golden_state_warriors.png", "MIL":"milwaukee_bucks.png","TOR":"toronto_raptors", "IND":"indiana_pacers.png","TOT":"generic_team.png"]
    var team: Team?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableElements();
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    private func configureTableElements(){
        print(team!.pf);
        var totalPoints: Double = 0;
        var totalRebounds: Double = 0;
        var totalAssists: Double = 0;
        var playerCount: Int16 = 0;
        var averageFg: Double = 0;
        var averageFg3: Double = 0;
        var averageAge: Int16 = 0;
        
        teamTitleLabel.text = team!.name;
        teamCreatorLabel.text = "Created By: \(team!.creator!)";
        
        DispatchQueue.main.async {
            
        
        // PG configuration
            if (self.team!.pg != nil){
            playerCount += 1;
                totalPoints += self.team!.pg!.pts;
                totalAssists += self.team!.pg!.ast;
                totalRebounds += self.team!.pg!.reb;
                averageFg += self.team!.pg!.fg;
                averageFg3 += self.team!.pg!.fg3;
                averageAge += self.team!.pg!.age;
            
            
                self.pgNameLabel.text = self.team!.pg!.name!;
                self.pgTeamImageView.image = UIImage(named: self.teamToImage[self.team!.pg!.team!]!);
                if let playerImage = UIImage(named: self.team!.pg!.imageName!) {
                    self.pgImageView.image = playerImage;
            } else {
                    self.pgImageView.image = UIImage(named: "Generic.png");
            }
        } else {
            self.pgNameLabel.text = "None";
            self.pgImageView.image = UIImage(named: "generic_team.png");
            self.pgTeamImageView.image = UIImage(named: "generic_team.png");
        }
        
        // SG configuration
            if (self.team!.sg != nil){
            playerCount += 1;
                totalPoints += self.team!.sg!.pts;
                totalAssists += self.team!.sg!.ast;
                totalRebounds += self.team!.sg!.reb;
                averageFg += self.team!.sg!.fg;
                averageFg3 += self.team!.sg!.fg3;
                averageAge += self.team!.sg!.age;
            
            
                self.sgNameLabel.text = self.team!.sg!.name!;
                self.sgTeamImageView.image = UIImage(named: self.teamToImage[self.team!.sg!.team!]!);
                if let playerImage = UIImage(named: self.team!.sg!.imageName!) {
                self.sgImageView.image = playerImage;
            } else {
                self.sgImageView.image = UIImage(named: "Generic.png");
            }
        } else {
            self.sgNameLabel.text = "None";
            self.sgImageView.image = UIImage(named: "generic_team.png");
            self.sgTeamImageView.image = UIImage(named: "generic_team.png");
        }
        
        // SF configuration
            if (self.team!.sf != nil){
            playerCount += 1;
            totalPoints += self.team!.sf!.pts;
            totalAssists += self.team!.sf!.ast;
            totalRebounds += self.team!.sf!.reb;
            averageFg += self.team!.sf!.fg;
            averageFg3 += self.team!.sf!.fg3;
            averageAge += self.team!.sf!.age;
            
            
                self.sfNameLabel.text = self.team!.sf!.name!;
            self.sfTeamImageView.image = UIImage(named: self.teamToImage[self.team!.sf!.team!]!);
            if let playerImage = UIImage(named: self.team!.sf!.imageName!) {
                self.sfImageView.image = playerImage;
            } else {
                self.sfImageView.image = UIImage(named: "Generic.png");
            }
        } else {
            self.sfNameLabel.text = "None";
            self.sfImageView.image = UIImage(named: "generic_team.png");
            self.sfTeamImageView.image = UIImage(named: "generic_team.png");
        }
        
        // PF configuration
            if (self.team!.pf != nil){
                playerCount += 1;
                totalPoints += self.team!.pf!.pts;
                totalAssists += self.team!.pf!.ast;
                totalRebounds += self.team!.pf!.reb;
                averageFg += self.team!.pf!.fg;
                averageFg3 += self.team!.pf!.fg3;
                averageAge += self.team!.pf!.age;
                print("Center: \(self.team!.pf!)");
                self.pfNameLabel.text = self.team!.pf!.name!;
                self.pfTeamImageView.image = UIImage(named: self.teamToImage[self.team!.pf!.team!]!);
                if let playerImage = UIImage(named: self.team!.pf!.imageName!) {
                    self.pfImageView.image = playerImage;
                } else {
                    self.pfImageView.image = UIImage(named: "Generic.png");
                }
            } else {
                self.pfNameLabel.text = "None";
                self.pfImageView.image = UIImage(named: "generic_team.png");
                self.pfTeamImageView.image = UIImage(named: "generic_team.png");
            }
            
        
        // C configuration
            if (self.team!.c != nil){
            playerCount += 1;
            totalPoints += self.team!.c!.pts;
            totalAssists += self.team!.c!.ast;
            totalRebounds += self.team!.c!.reb;
            averageFg += self.team!.c!.fg;
            averageFg3 += self.team!.c!.fg3;
            averageAge += self.team!.c!.age;
            print("Center: \(self.team!.c!)");
            self.cNameLabel.text = self.team!.c!.name!;
            self.cTeamImageView.image = UIImage(named: self.teamToImage[self.team!.c!.team!]!);
            if let playerImage = UIImage(named: self.team!.c!.imageName!) {
                self.cImageView.image = playerImage;
            } else {
                self.cImageView.image = UIImage(named: "Generic.png");
            }
        } else {
            self.cNameLabel.text = "None";
            self.cImageView.image = UIImage(named: "generic_team.png");
            self.cTeamImageView.image = UIImage(named: "generic_team.png");
        }
        
            
        // Stats configuration
            self.totalPointsLabel.text =  "\(Int(totalPoints))";
            self.totalAssistsLabel.text = "\(Int(totalAssists))";
            self.totalReboundsLabel.text = "\(Int(totalRebounds))";
            if playerCount != 0 {
                averageFg = averageFg / Double(playerCount);
                averageFg3 = averageFg3 / Double(playerCount);
                averageAge = averageAge / playerCount;
            } else{
                averageFg = 0;
                averageFg3 = 0;
                averageAge = 0;
            }
            self.averageFieldGoalLabel.text = String(format:"%.3f", averageFg);
            self.averageFieldGoal3Label.text = String(format:"%.3f", averageFg3);
            self.averageAgeLabel.text = "\(averageAge)";
        }
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 6;
        }
        else{
            return 3;
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
