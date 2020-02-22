//
//  TrainCell.swift
//  MeTA
//
//  Created by salman siraj on 2/21/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import UIKit

class TrainCell: UITableViewCell {

    @IBOutlet weak var trainImageView: UIImageView!
    @IBOutlet weak var trainName: UILabel!
    
    func setTrain(train: Train) {
        trainImageView.image = train.image
        trainName.text = train.title
    }
    
}
