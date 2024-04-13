//
//  CalenderCollectionViewCell.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import UIKit

class CalenderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    static let identifier = "CalenderCollectionViewCell"
    @IBOutlet weak var dateLabel: UILabel!
        @IBOutlet weak var dayLabel: UILabel!
        @IBOutlet weak var monthLabel: UILabel!
        
        func configure(with date: Date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d"
            var str = dateFormatter.string(from: date)
            dateLabel.text = String(str.prefix(3))
            
            dateFormatter.dateFormat = "EEEE"
            dayLabel.text =  String(dateFormatter.string(from: date).prefix(3))
            
            dateFormatter.dateFormat = "MMMM"
            monthLabel.text = String(dateFormatter.string(from: date).prefix(3))
        }
    
    func changeUIBySelected(isSelected:Bool){
        
        if isSelected {
            mainView.backgroundColor = ColorConstant.selectedCardBgColor
           dateLabel.textColor = .white
            dayLabel.textColor = .white
            monthLabel.textColor = .white// Change to whatever color you want for the selected cell
        } else {
            
           dateLabel.textColor = ColorConstant.primaryTextColor
            dayLabel.textColor = ColorConstant.primaryTextColor
           monthLabel.textColor = ColorConstant.primaryTextColor
            mainView.backgroundColor = .white // Change to your default color
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
