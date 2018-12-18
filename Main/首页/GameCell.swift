//
//  GameCell.swift
//  sports
//
//  Created by --- on 2018/12/10.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {

    @IBOutlet weak var playBtn: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var bmBtn: UIButton!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var model:GameModel?{
        
        didSet{
            
            showData()
        }
    }
    
    //视频数据
    var playModel:MasterVideo?{
        
        didSet{
            
            showPlayData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        introLabel.sizeToFit()
        introLabel.minimumScaleFactor = 0.5
        timeLabel.sizeToFit()
        timeLabel.minimumScaleFactor = 0.5
        addressLabel.sizeToFit()
        addressLabel.minimumScaleFactor = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showData(){
        
        playBtn.isHidden = true
        
        nameLabel.text = model?.name
        introLabel.text = model?.intro
        //icon.kf.setImage(with: URL.init(string: (model?.imageName)!))
        icon.sd_setImage(with: URL.init(string: (model?.imageName)!), completed: nil)
        addressLabel.text = "地址:" + (model?.address)!
        timeLabel.text = "时间:" + (model?.startTime)!
        
        
    }
    
    func showPlayData(){
        
        timeLabel.isHidden = true
        addressLabel.isHidden = true
        bmBtn.isHidden = true
        introLabel.isHidden = true
        nameLabel.isHidden = true
        
        //icon.kf.setImage(with: URL.init(string: (playModel?.image)!))
        icon.sd_setImage(with: URL.init(string: (playModel?.image)!), completed: nil)
    }
    
    @IBAction func clickBtn(_ sender: Any) {
        
        
    }
}
