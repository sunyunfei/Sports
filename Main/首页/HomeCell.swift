//
//  HomeCell.swift
//  sports
//
//  Created by --- on 2018/12/10.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    var model:HomeModel?{
        
        didSet{
            
            showData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        SportsTools.cutEvent(icon, false, 4, 0, UIColor.white)
    }
    
    //取消报名
    @IBAction func clickCancelBtn(_ sender: Any) {
        
        //取消  post_deleteCareCourse
        BmobTools.post_deleteActive((model?.homeId)!, success: {
            
            self.contentView.hideToastActivity()
            NotificationCenter.default.post(name: NSNotification.Name.init("refresh"), object: nil)
        }) { (error) in
            
            self.contentView.hideToastActivity()
            self.contentView.makeToast(error)
        }
    }
    
    func showData(){
        
        nameLabel.text = model?.name
        introLabel.text = model?.intro
        timeLabel.text = model?.time
        //icon.kf.setImage(with: URL.init(string: (model?.imageName)!))
        icon.sd_setImage(with: URL.init(string: (model?.imageName)!), completed: nil)
    }
    
}
