//
//  EventTableViewCell.swift
//  RealmDB
//
//  Created by Ekrem Özkaraca on 29.12.2021.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    static let identifier = "EventTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "EventTableViewCell", bundle: nil)
    }

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    private let colors : [UIColor] = [
        .systemBlue, .systemRed, .systemPink, .systemTeal, .systemGreen, .systemYellow, .systemPurple, .systemOrange, .systemIndigo, .brown, .cyan, .magenta
    ]
    
    func configure(data : Events) {
        eventNameLabel.text = data.eventName
        companyNameLabel.text = data.companyName
        let startTime = dateSet(timeText: data.startTime)
        startTimeLabel.text = startTime
        let endTime = dateSet(timeText: data.endTime)
        endTimeLabel.text = endTime
    }
    
    func dateSet(timeText : String?) -> String {
        if let time = timeText {
            var editedName = time
            let otherRange = editedName.index(editedName.startIndex, offsetBy: 0)..<editedName.index(editedName.endIndex, offsetBy: -5)
            editedName.removeSubrange(otherRange)
            return editedName
        } else {
            return "not set"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code 
        backView.cardView() // istenilmiyor ise, tableview seperator aç
        colorView.layer.cornerRadius = 5
        colorView.backgroundColor = colors.randomElement()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
