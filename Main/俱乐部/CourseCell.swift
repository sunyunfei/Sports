//
//  CourseCell.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/21.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {

    @IBOutlet weak var bmBtn: UIButton!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var cocahLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var model:ClubCourseModel?{
        
        didSet{
            
            show();
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        introLabel.minimumScaleFactor = 0.4
        introLabel.adjustsFontSizeToFitWidth = true
        
        bmBtn.setTitle("取消", for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    //数据处理
    func show(){
        
        nameLabel.text = model?.name
        introLabel.text = model?.intro
        cocahLabel.text = "教练:" + (model?.coach)!
    }
    
    // 报名
    
    @IBAction func clickBmBtn(_ sender: Any) {
        
        self.contentView.makeToastActivity(.center)
        if bmBtn.isSelected{
            
            //取消  post_deleteCareCourse
            BmobTools.post_deleteCareCourse(courseId: (model?.courseId)!, success: {
                
                self.contentView.hideToastActivity()
                NotificationCenter.default.post(name: NSNotification.Name.init("refresh"), object: nil)
            }) { (error) in
                
                self.contentView.hideToastActivity()
                self.contentView.makeToast(error)
            }
            
        }else{
            //报名
            self.contentView.makeToastActivity(.center)
            BmobTools.post_carecourse(model!, success: {
                
                self.contentView.hideToastActivity()
                self.contentView.makeToast("报名成功")
            }) { (error) in
                
                self.contentView.hideToastActivity()
                self.contentView.makeToast(error)
            }
        }
    }
    
}
