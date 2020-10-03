//
//  filterOptions.swift
//  NBA-Stats-Teams
//
//  Created by Noah Taylor on 4/30/20.
//  Copyright © 2020 Noah Taylor. All rights reserved.
//

import Foundation

class filterOptions{
    var positionIndex: Int;
    var teamIndex: Int;
    var teamName: String;
    var pointsMin: Double;
    var assistsMin: Double;
    var reboundsMin: Double;
    var ageMin: Int;
    var fieldgoalMin: Double;
    var fieldgoal3Min: Double;
    
    init(positionIndex: Int, teamIndex: Int, teamName: String, pointsMin: Double, assistsMin: Double, reboundsMin: Double, ageMin: Int, fieldgoalMin: Double, fieldgoal3Min: Double) {
        self.positionIndex = positionIndex;
        self.teamIndex = teamIndex;
        self.teamName = teamName;
        self.pointsMin = pointsMin;
        self.assistsMin = assistsMin;
        self.reboundsMin = reboundsMin;
        self.ageMin = ageMin;
        self.fieldgoalMin = fieldgoalMin;
        self.fieldgoal3Min = fieldgoal3Min;
    }
    
}
