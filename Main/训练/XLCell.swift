//
//  XLCell.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/18.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit

class XLCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var model:XLModel?{
        
        didSet{
            
            self.showData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //数据解析
    func showData(){
    
        icon.sd_setImage(with: URL.init(string: (model?.icon)!), completed: nil)
        nameLabel.text = model?.name
    }
}
