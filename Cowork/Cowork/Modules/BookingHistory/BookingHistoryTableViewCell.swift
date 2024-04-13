//
//  BookingHistoryTableViewCell.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import UIKit

class BookingHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var deskRoomLbl: UILabel!
    @IBOutlet weak var bookOnLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var deskIdNoLbl: UILabel!
    static let identifier = "BookingHistoryTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
