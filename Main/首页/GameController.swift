//
//  GameController.swift
//  sports
//
//  Created by --- on 2018/12/10.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
let game_cell = "GameCell"
class GameController: RootTableViewController {

    var masterId:String?
    var isGame:Bool = true
    var datas:Array<GameModel> = Array()
    //视频数据
    var playDatas:Array<MasterVideo> = Array()
    
    /** 播放器 */
    var playerVC: AVPlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isGame{
            self.title = "比赛"
            
            
            
        }else{
            
            self.title = "大师视频"
            playerVC = AVPlayerViewController()
        }
        
        self.view.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib.init(nibName: game_cell, bundle: nil), forCellReuseIdentifier: game_cell)
        self.tableView.tableFooterView = UIView.init()
        //获取数据
        refreshData()
    }
    
    //数据刷新
    override func refreshData(){
        
        self.view.makeToastActivity(.center)
        
        if isGame{
            
            BmobTools.post_game(success: { (array) in
                self.view.hideToastActivity()
                self.datas = array
                self.tableView.reloadData()
            }) { (error) in
                
                self.view.hideToastActivity()
                self.view.makeToast(error)
            }
        }else{
            
            BmobTools.post_masterVideo(masterId!, success: { (array) in
                self.view.hideToastActivity()
                self.playDatas = array
                self.tableView.reloadData()
            }) { (error) in
                
                self.view.hideToastActivity()
                self.view.makeToast(error)
            }
        }
    }
    
    //播放视频
    func playVideo(_ url:String){
        
        let remoteURL = NSURL(string: url)
        let player = AVPlayer(url: remoteURL! as URL)
        playerVC?.player = player
        
        if let vc = playerVC{
            
            self.present(vc, animated: true, completion: nil)
            playerVC?.player?.play()
        }
        
    }
    
    //表的代理事件
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isGame{
            return self.datas.count
        }else{
            return self.playDatas.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:GameCell = tableView.dequeueReusableCell(withIdentifier: game_cell, for: indexPath) as! GameCell
        if isGame {
            
            cell.model = self.datas[indexPath.row]
        }else{
            
            cell.playModel = self.playDatas[indexPath.row]
        }
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isGame{
            
            return 100
        }else{
            
            return 150
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        
        if isGame{
            
        }else{
            
            //播放视频
            let model:MasterVideo = self.playDatas[indexPath.row]
            if let str = model.video{
                
                playVideo(str)
            }
        }
    }

    
}
