//
//  DraftTableViewController.swift
//  NBA-Stats-Teams
//
//  Created by Noah Taylor on 4/30/20.
//  Copyright © 2020 Noah Taylor. All rights reserved.
//

import UIKit
import CoreData

class DraftTableViewController: UITableViewController {
    
    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?;
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    var teams: [Team] = []
    var playerToDraft: Player?;
    var teamSelected: Team?;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate;
        managedObjectContext = appDelegate.persistentContainer.viewContext;
        configureFetchedResultsController();
        getTeams();
        
    }

    private func configureFetchedResultsController(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team");
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
    
    private func getTeams(){
        teams = [];
        for team in fetchedResultsController?.fetchedObjects! as! [Team]{
            teams.append(team);
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return teams.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! TeamTableViewCell;

        let team = teams[indexPath.row];
        print("team: \(team.name!) creator: \(team.creator!)")
        cell.teamNameLabel.text = team.name!;
        cell.teamCreatorLabel.text = team.creator!;

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index Row: \(indexPath.row)")
        teamSelected = teams[indexPath.row];
        print("team Selected: \(teamSelected)");
        print("player Selected: \(playerToDraft!)")
        draftPlayer(team: teamSelected!, player: playerToDraft!);
        if let naVController = self.navigationController {
            naVController.popViewController(animated: true);
        }
        
    }
    
    func draftPlayer(team: Team, player: Player){
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team");
        let context = appDelegate.persistentContainer.viewContext;
        fetchedRequest.predicate = NSPredicate(format: "name = %@ AND creator = %@", argumentArray: [team.name!,team.creator!]);
        print("Fetch Predicate: name = \(team.name!) AND creator = \(team.creator!)")
        do{
            let results = try context.fetch(fetchedRequest) as? [NSManagedObject]
            print("results: \(results)")
            if results?.count != 0 {
                switch player.pos! {
                case "PG":
                    results![0].setValue(player, forKey: "pg")
                case "SG":
                    results![0].setValue(player, forKey: "sg")
                case "SF":
                    results![0].setValue(player, forKey: "sf")
                case "PF":
                    results![0].setValue(player, forKey: "pf")
                case "C":
                    results![0].setValue(player, forKey: "c")
                default:
                    print("Error: No position matched")
                }
            }
        } catch {
            print("Fetch Failed: \(error)")
        }
        do {
            try context.save()
        } catch {
            print("Saving Core Data Failed")
        }
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
