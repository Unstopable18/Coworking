//
//  SlotCollectionViewCell.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import UIKit

class SlotCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainView: CustomUIView!
    @IBOutlet weak var titleLbl: UILabel!
    static let identifier = "SlotCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI(isActive:Bool){
        if isActive{
            self.mainView.backgroundColor = ColorConstant.cardLightBackgroundColor
            self.mainView.borderColor = ColorConstant.cardBorderColor
            self.titleLbl.textColor = ColorConstant.primaryTextColor
            
        }
        else{
            self.mainView.backgroundColor = ColorConstant.appGrayColor
            self.mainView.borderColor = .clear
            self.titleLbl.textColor = ColorConstant.primaryWhiteColor
            
        }
       
    }
}
