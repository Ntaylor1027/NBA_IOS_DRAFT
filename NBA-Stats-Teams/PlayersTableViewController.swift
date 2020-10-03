//
//  PlayersTableViewController.swift
//  NBA-Stats-Teams
//
//  Created by Noah Taylor on 4/28/20.
//  Copyright © 2020 Noah Taylor. All rights reserved.
//

import UIKit
import CoreData

class PlayersTableViewController: UITableViewController {

    
    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?;
    
    private var teamToImage: [String: String] = ["POR":"portland_trail_blazers.png", "CHO": "charlotte_hornets.png", "BOS":"boston_celtics.png", "ORL": "orlando_magic.png", "NYK":"new_york_knicks.png", "CLE":"cleveland_cavaliers.png", "PHI":"philadelphia_76s.png", "OKC": "okc_thunder.png", "SAC":"sacramento_kings.png", "SAS":"san_antonio_spurs.jpg", "CHI": "chicago_bulls.png", "DAL": "dallas_mavericks.jpg", "LAL":"la_lakers.png", "PHO": "phoenix_suns.png", "LAC":"la_clippers.png", "WAS":"washington_wizards.png", "DEN":"denver_nuggets.png", "ATL": "atlanta_hawks.png", "MIN": "minnesota_timberwolves.png", "MIA": "miami_heat.png","UTA":"utah_jazz.png", "DET":"detroit-pistons.png", "BRK": "brooklyn_nets.jpg", "HOU":"houston_rockets.png", "NOP":"new_orleans_pelicans.png", "MEM":"memphis_grizzlies.jpeg", "GSW":"golden_state_warriors.png", "MIL":"milwaukee_bucks.png","TOR":"toronto_raptors", "IND":"indiana_pacers.png","TOT":"generic_team.png"]
    
    
    
    var filterOptionsSelected: filterOptions = filterOptions(positionIndex: 0, teamIndex: 0, teamName: "Any", pointsMin: 0, assistsMin: 0, reboundsMin: 0, ageMin: 18, fieldgoalMin: 0, fieldgoal3Min: 0);
    var playerData: [Player] = [];
    var tableRows: Int = 0;
    var playerSelected: Player?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 55;
        configureFetchedResultsController();
        print("Filtering Players...");
        filterPlayers();
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: Gather Player Data
    
    private func configureFetchedResultsController(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player");
        let sortDescriptor = NSSortDescriptor(key:"name", ascending: true);
        fetchedRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil);
        fetchedResultsController?.delegate = self;
        do {
            try fetchedResultsController?.performFetch();
        } catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    // MARK: Filter Data
    private func filterPlayers(){
        playerData = []
        let positions = ["Any","PG","SG","SF","PF","C"]
        for player in fetchedResultsController?.fetchedObjects! as! [Player]{
            if (
                ((player.pos == positions[filterOptionsSelected.positionIndex]) || (filterOptionsSelected.positionIndex == 0)) && ((player.team == filterOptionsSelected.teamName) || (filterOptionsSelected.teamIndex == 0)) && player.pts >= filterOptionsSelected.pointsMin && player.ast >= filterOptionsSelected.assistsMin && player.reb >= filterOptionsSelected.reboundsMin && player.age >= filterOptionsSelected.ageMin && player.fg >= filterOptionsSelected.fieldgoalMin && player.fg3 >= filterOptionsSelected.fieldgoal3Min
                ){
                
                playerData.append(player);
            }
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        guard let sections = fetchedResultsController?.sections!.count else {
            return 0
        }
        return sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        guard let sections = fetchedResultsController?.sections else {
//                   return 0
//        }
//        let rowInfo = sections[section].numberOfObjects;
//        print("The amount of rows: \(rowInfo)")
        return playerData.count;
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell;

        let player = playerData[indexPath.row];
        cell.playerName.text = player.name;
        let imageName = teamToImage[player.team!]
        if let playerImage = UIImage(named: player.imageName!) {
            cell.playerImage.image = UIImage(named: player.imageName!);
        } else {
            cell.playerImage.image = UIImage(named: "Generic.png");
        }
            
            cell.teamImage.image = UIImage(named: imageName!);
            cell.positionLabel.text = "POS: \(player.pos!)"
        

        return cell
    }
    

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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index Row: \(indexPath.row)")
        self.playerSelected = playerData[indexPath.row];
        print("Player Selected: \(playerSelected)")
        performSegue(withIdentifier: "fromPlayerTableToPlayerDetail", sender: self);
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "fromPlayerTableToFilterTable"){
            let filterVC = segue.destination as! FilterTableViewController
            filterVC.filterOptionsForLoading = filterOptionsSelected;
        } else if (segue.identifier == "fromPlayerTableToPlayerDetail"){
            let playerDetailVC = segue.destination as! PlayerDetailViewController;
                        
            playerDetailVC.ageValue = "Age: \(playerSelected!.age)";
            playerDetailVC.assistValue = String(format:"%.2f", playerSelected!.ast);
            playerDetailVC.fieldgoal3Value = String(format:"%.3f", playerSelected!.fg3);
            playerDetailVC.fieldgoalValue = String(format:"%.3f", playerSelected!.fg);
            playerDetailVC.playerNameValue = playerSelected!.name;
            playerDetailVC.pointsValue = String(format: "%.2f", playerSelected!.pts);
            playerDetailVC.positionValue = "Pos: \(playerSelected!.pos!)";
            playerDetailVC.reboundValue = String(format: "%.2f", playerSelected!.reb);
            playerDetailVC.teamImageValue =  teamToImage[playerSelected!.team!]!;
            if let playerImage = UIImage(named: playerSelected!.imageName!) {
                playerDetailVC.playerImageValue = playerSelected!.imageName!
            } else {
                playerDetailVC.playerImageValue = "Generic.png"
            }
            playerDetailVC.playerToDraft = playerSelected;
            
            
        }
    }
    
    @IBAction func unwindFromFilterViewSave (sender: UIStoryboardSegue) {
        let filterVC = sender.source as! FilterTableViewController
//        filterOptionsSelected.positionIndex = filterVC.positionIndexSelected
//        filterOptionsSelected.teamIndex = filterVC.teamIndexSelected;
//        filterOptionsSelected.teamName = filterVC.teamSelected;
//        filterOptionsSelected.pointsMin = filterVC.pointsSelected;
//        filterOptionsSelected.assistsMin = filterVC.assistsSelected;
//        filterOptionsSelected.reboundsMin = filterVC.reboundsSelected;
//        filterOptionsSelected.ageMin = filterVC.ageSelected;
//        filterOptionsSelected.fieldgoalMin = filterVC.fieldgoalSelected;
//        filterOptionsSelected.fieldgoal3Min = filterVC.fieldgoal3Selected;
        filterOptionsSelected = filterVC.filterOptionsForLoading!;
        filterPlayers();
        tableView.reloadData();
    }
    
    
    @IBAction func unwindFromFilterViewCancel (sender: UIStoryboardSegue) {
        
    }
    
    


}

extension UITableViewController: NSFetchedResultsControllerDelegate{
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("The Controller content has changed");
        tableView.reloadData();
    }
}
