//
//  STCell.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/21.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit

class STCell: UITableViewCell {

    var model:STModel?{
        
        didSet{
            
            showData()
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showData(){
        
        icon.sd_setImage(with: URL.init(string: (model?.icon)!), completed: nil)
        nameLabel.text = model?.userName
        timeLabel.text = model?.time
        introLabel.text = model?.intro
    }
    
}
