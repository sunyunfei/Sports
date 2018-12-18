//
//  MasterQuestionCell.swift
//  sports
//
//  Created by --- on 2018/12/11.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

class MasterQuestionCell: UITableViewCell {

    @IBOutlet weak var userAskLabel: UILabel!
    @IBOutlet weak var masterLabel: UILabel!
    var model:MasterQuestion?{
        
        didSet{
            showData()
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
    
    func showData(){
        
        userAskLabel.text = (model?.userName)! + " 提出了一个问题:\n       " + (model?.question)!
        if let str = model?.replay{
            
            if str.count > 0{
                masterLabel.text = "大师回复:\n     " + str
            }else{
                masterLabel.text = "大师还没有回复他呢!!!"
            }
        }else{
            
            masterLabel.text = "大师还没有回复他呢!!!"
        }
    }
    
}
