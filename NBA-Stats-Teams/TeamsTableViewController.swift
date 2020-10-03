//
//  TeamsTableViewController.swift
//  NBA-Stats-Teams
//
//  Created by Noah Taylor on 4/30/20.
//  Copyright © 2020 Noah Taylor. All rights reserved.
//

import UIKit
import CoreData

class TeamsTableViewController: UITableViewController {

    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?;
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    var teams: [Team] = []
    var teamSelected: Team?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        configureFetchedResultsController();
        getTeams();
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cell.teamNameLabel.text = team.name;
        cell.teamCreatorLabel.text = team.creator;
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let row = indexPath.row;
            let teamToDelete = teams[row];
            removeTeam(teamToDelete);
            teams.remove(at: row);
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "fromTeamsViewToTeamDetails"){
            let detailVC = segue.destination as! TeamDetailsTableViewController;
            detailVC.team = teamSelected;

        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        teamSelected = teams[indexPath.row];
        performSegue(withIdentifier: "fromTeamsViewToTeamDetails", sender: nil)
        
        
    }
    
    @IBAction func unwindFromCreateTeamViewAdd (sender: UIStoryboardSegue) {
        let createTeamVC = sender.source as! CreateTeamViewController;
        let name = createTeamVC.teamNameTextField.text;
        let creator = createTeamVC.teamCreatorTextField.text;
        
        if (name!.count != 0 && creator!.count != 0){
            print("\(name)...\(creator)")
            addTeam(name: name!, creator: creator!);
        }
        getTeams();
        tableView.reloadData();
    }
    
    
    @IBAction func unwindFromCreateTeamViewCancel (sender: UIStoryboardSegue) {
        
    }
    
    func addTeam (name: String, creator: String){
        let newTeam = NSEntityDescription.insertNewObject(forEntityName:
            "Team", into: self.managedObjectContext)
        newTeam.setValue(name, forKey: "name")
        newTeam.setValue(creator, forKey: "creator")
        appDelegate.saveContext() // In AppDelegate.swift
    }

    func removeTeam(_ team: NSManagedObject) {
        managedObjectContext.delete(team)
        appDelegate.saveContext()
    }
    
    
}
