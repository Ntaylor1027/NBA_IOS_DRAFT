//
//  FilterTableViewController.swift
//  NBA-Stats-Teams
//
//  Created by Noah Taylor on 4/30/20.
//  Copyright © 2020 Noah Taylor. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController,  UIPickerViewDelegate, UIPickerViewDataSource {

    
    // MARK: Menu Items
    @IBOutlet weak var positionPickerMenu: UIPickerView!
    @IBOutlet weak var teamPickerMenu: UIPickerView!
    @IBOutlet weak var pointsSelectedLabel: UILabel!
    @IBOutlet weak var pointsSlider: UISlider!
    @IBOutlet weak var assistsSelectedLabel: UILabel!
    @IBOutlet weak var assistsSlider: UISlider!
    @IBOutlet weak var reboundsSelectedLabel: UILabel!
    @IBOutlet weak var reboundsSlider: UISlider!
    @IBOutlet weak var ageSelectedLabel: UILabel!
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var fieldgoalSelectedLabel: UILabel!
    @IBOutlet weak var fieldgoalSlider: UISlider!
    @IBOutlet weak var fieldgoal3SelectedLabel: UILabel!
    @IBOutlet weak var fieldgoal3Slider: UISlider!
    
    
    
    // MARK: Menu Configuration variables
    let positions = ["Any","PG","SG","SF","PF","C"]
    
    let teams = ["Any","ATL","BOS", "BRK", "CHO", "CHI", "CLE", "DAL", "DEN", "DET", "GSW", "HOU", "IND", "LAC", "LAL", "MEM", "MIA", "MIL", "MIN", "NOP", "NYK", "OKC", "ORL", "PHI", "PHO", "POR", "SAC", "SAS", "TOR", "TOT", "UTA", "WAS"]
    
    
    // MARK: User Selected Variables
    var positionSelected: String = "";
    var positionIndexSelected: Int = 0;
    var teamSelected: String = "";
    var teamIndexSelected: Int = 0;
    var pointsSelected: Double = 0;
    var assistsSelected: Double = 0;
    var reboundsSelected: Double = 0;
    var ageSelected: Int = 0;
    var fieldgoalSelected: Double = 0;
    var fieldgoal3Selected: Double = 0;
    var filterOptionsForLoading: filterOptions?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set tags to allow for multiple picker menus
        self.positionPickerMenu.tag = 1
        self.teamPickerMenu.tag = 2
        self.positionPickerMenu.delegate = self;
        self.positionPickerMenu.dataSource = self;
        self.teamPickerMenu.delegate = self;
        self.teamPickerMenu.dataSource = self;
        
        loadFilterData();
    }
    
    // MARK: Load Filter Data From User
    
    func loadFilterData(){
        self.positionPickerMenu.selectRow(filterOptionsForLoading!.positionIndex, inComponent:0, animated: true);
        self.teamPickerMenu.selectRow(filterOptionsForLoading!.teamIndex, inComponent:0, animated: true);
        
        
        let pointsValue = Float(filterOptionsForLoading!.pointsMin);
        let assistsValue = Float(filterOptionsForLoading!.assistsMin);
        let reboundsValue = Float(filterOptionsForLoading!.reboundsMin);
        let ageValue = Float(filterOptionsForLoading!.ageMin);
        let fieldgoalValue = Float(filterOptionsForLoading!.fieldgoalMin);
        let fieldgoal3Value = Float(filterOptionsForLoading!.fieldgoal3Min);
        
        self.pointsSlider.setValue(pointsValue, animated: true);
        self.pointsSelectedLabel.text = String(format: "%.2f", pointsSlider.value);
        self.assistsSlider.setValue(assistsValue, animated: true);
        self.assistsSelectedLabel.text = String(format: "%.2f", assistsSlider.value);
        self.reboundsSlider.setValue(reboundsValue, animated: true);
        self.reboundsSelectedLabel.text = String(format: "%.2f", reboundsSlider.value);
        self.ageSlider.setValue(ageValue, animated: true);
        self.ageSelectedLabel.text = String(ageSlider.value);
        self.fieldgoalSlider.setValue(fieldgoalValue, animated: true);
        self.fieldgoalSelectedLabel.text = String(format: "%.3f", fieldgoalSlider.value);
        self.fieldgoal3Slider.setValue(fieldgoal3Value, animated: true);
        self.fieldgoal3SelectedLabel.text = String(format: "%.3f", fieldgoal3Slider.value);
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    
    // MARK: MENU CONFIGURATION
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return positions.count
        }
        else if pickerView.tag == 2{
            return teams.count
        }
        else{
            return 0;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            positionSelected = positions[row];
            positionIndexSelected = row;
            filterOptionsForLoading!.positionIndex = positionIndexSelected
            print("position selected: \(positionSelected), positionIndexSelected: \(positionIndexSelected)")
            return positions[row];
        }else {
            teamSelected = teams[row];
            teamIndexSelected = row;
            filterOptionsForLoading!.teamIndex = teamIndexSelected;
            filterOptionsForLoading!.teamName = teamSelected;
            print("team selected: \(teamSelected), teamIndex: \(teamIndexSelected)")
            return teams[row];
        }
        
    }
    
    @IBAction func pointsSliderDidChange(_ sender: UISlider) {
        pointsSelected = Double(sender.value);
        filterOptionsForLoading!.pointsMin = pointsSelected;
        pointsSelectedLabel.text = String(format: "%.2f",sender.value);
    }
    
    @IBAction func assistsSliderDidChange(_ sender: UISlider) {
        assistsSelected = Double(sender.value);
        filterOptionsForLoading!.assistsMin = assistsSelected;
        assistsSelectedLabel.text = String(format: "%.2f",sender.value);
    }
    
    @IBAction func reboundsSliderDidChange(_ sender: UISlider) {
        reboundsSelected = Double(sender.value)
        filterOptionsForLoading!.reboundsMin = reboundsSelected;
        reboundsSelectedLabel.text = String(format: "%.2f",sender.value);
    }
    
    @IBAction func ageSliderDidChange(_ sender: UISlider) {
        ageSelected = Int(sender.value)
        filterOptionsForLoading!.ageMin = ageSelected;
        ageSelectedLabel.text = String(Int(sender.value));
    }
    
    @IBAction func fieldgoalSliderDidChange(_ sender: UISlider) {
        fieldgoalSelected = Double(sender.value)
        filterOptionsForLoading!.fieldgoalMin = fieldgoalSelected;
        fieldgoalSelectedLabel.text = String(format: "%.2f",sender.value);
    }
    
    @IBAction func fieldgoal3SliderDidChange(_ sender: UISlider) {
        fieldgoal3Selected = Double(sender.value)
        filterOptionsForLoading!.fieldgoal3Min = fieldgoal3Selected;
        fieldgoal3SelectedLabel.text = String(format: "%.2f",sender.value);
    }
    
}
