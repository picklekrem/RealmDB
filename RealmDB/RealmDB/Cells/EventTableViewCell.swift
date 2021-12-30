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
    
//    var eventViewModel : EventViewModel {
//        didSet {
//            eventNameLabel.text = eventViewModel.eventName
//            companyNameLabel.text = eventViewModel.companyName
//            startTimeLabel.text = String(describing: eventViewModel.startTime)
//            endTimeLabel.text = String(describing: eventViewModel.endTime)
//        }
//    }

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
