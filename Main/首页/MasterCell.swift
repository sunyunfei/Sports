//
//  MasterCell.swift
//  sports
//
//  Created by --- on 2018/12/10.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit
class MasterCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deslabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    var model:MasterModel?{
        
        didSet{
            
            showData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        SportsTools.cutEvent(icon, true, (self.frame.size.height - 12) / 2, 1, UIColor.lightGray)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func showData(){
        
        //icon.kf.setImage(with: URL.init(string: (model?.icon)!))
        icon.sd_setImage(with: URL.init(string: (model?.icon)!), completed: nil)
        nameLabel.text = model?.name
        deslabel.text = model?.describe
    }
}
