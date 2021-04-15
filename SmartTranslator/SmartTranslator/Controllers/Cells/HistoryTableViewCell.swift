//
//  HistoryTableViewCell.swift
//  SmartTranslator
//
//  Created by Yasir Tahir Ali on 14/04/2021.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var txtLblFrom: UILabel!
    @IBOutlet weak var txtLblTo: UILabel!
    @IBOutlet weak var txtLblFromText: UILabel!
    @IBOutlet weak var txtLblToText: UILabel!
    @IBOutlet weak var txtDateTime: UILabel!
    @IBOutlet weak var cellBackground: UIView!
    
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // B190E6
    func setCellBackground(){
        if (index % 2) == 0 {
            self.setWhiteBackground()
        } else {
            self.setPurpleBackground()
        }
    }
    
    func setWhiteBackground(){
        self.cellBackground.backgroundColor = UIColor.white
        
        self.txtLblFrom.textColor = UIColor(rgb: 0xB190E6)
        self.txtLblTo.textColor = UIColor(rgb: 0xB190E6)
        self.txtLblFromText.textColor = UIColor(rgb: 0xB190E6)
        self.txtLblToText.textColor = UIColor(rgb: 0xB190E6)
        self.txtDateTime.textColor = UIColor(rgb: 0xB190E6)
        
    }
    
    func setPurpleBackground(){
        self.cellBackground.backgroundColor = UIColor(rgb: 0xB190E6)
        
        self.txtLblFrom.textColor = UIColor(rgb: 0xFFFFFF)
        self.txtLblTo.textColor = UIColor(rgb: 0xFFFFFF)
        self.txtLblFromText.textColor = UIColor(rgb: 0xFFFFFF)
        self.txtLblToText.textColor = UIColor(rgb: 0xFFFFFF)
        self.txtDateTime.textColor = UIColor(rgb: 0xFFFFFF)
    }
}
