//
//  ConversationListViewController.swift
//  MyCloudIM
//
//  Created by chetaofeng on 16/6/17.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class ConversationListViewController: RCConversationListViewController {

    let conversationVC = RCConversationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.connectServer({ 
            self.title = "消息"
            
            //设置回话类型
            self.setDisplayConversationTypes([
                RCConversationType.ConversationType_APPSERVICE.rawValue,
                RCConversationType.ConversationType_CHATROOM.rawValue,
                RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue,
                RCConversationType.ConversationType_DISCUSSION.rawValue,
                RCConversationType.ConversationType_GROUP.rawValue,
                RCConversationType.ConversationType_PRIVATE.rawValue,
                RCConversationType.ConversationType_PUSHSERVICE.rawValue,
                RCConversationType.ConversationType_SYSTEM.rawValue
            ])
            
            self.isShowNetworkIndicatorView = true
            self.showConnectingStatusOnNavigatorBar = true
            self.conversationListTableView.tableFooterView = UIView()
            
            self.refreshConversationTableViewIfNeeded() //显示会话列表
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as? ConversationViewController
        destVC?.targetId = conversationVC.targetId
//        destVC?.userName = conversationVC.userName
        destVC?.conversationType = conversationVC.conversationType
        destVC?.title = conversationVC.title
        destVC?.setMessageAvatarStyle(.USER_AVATAR_CYCLE) //设置头像样式
    
        self.tabBarController?.tabBar.hidden = true
    }
    
    
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        // 代码方式跳转
        /*
        let conversationVC = RCConversationViewController()
        conversationVC.targetId = model.targetId
        conversationVC.userName = model.conversationTitle
        conversationVC.conversationType = RCConversationType.ConversationType_PRIVATE
        conversationVC.title = model.conversationTitle
        self.navigationController?.pushViewController(conversationVC, animated: true)
        self.tabBarController?.tabBar.hidden = true
        */
        
        
        conversationVC.targetId = model.targetId
//        conversationVC.userName = model.conversationTitle
        conversationVC.conversationType = RCConversationType.ConversationType_PRIVATE
        conversationVC.title = model.conversationTitle
        self.performSegueWithIdentifier("tabOnCell", sender: self)
    }
    
    override func willDisplayConversationTableCell(cell: RCConversationBaseCell!, atIndexPath indexPath: NSIndexPath!) {
        let model = self.conversationListDataSource[indexPath.row]
        if model.conversationType == .ConversationType_PRIVATE {
            let tmpCell = cell as! RCConversationCell
            tmpCell.conversationTitle.tintColor = UIColor.redColor()
        }
    }
    
    
    @IBAction func showMenu(sender: AnyObject) {
        var frame = sender.valueForKey("view")?.frame
        frame?.origin.y = (frame?.origin.y)! + 30
        
        KxMenu.showMenuInView(self.view, fromRect: frame!, menuItems:[
            KxMenuItem("加好友", image: nil, target: self, action: "clickAdd"),
            KxMenuItem("扫一扫", image: nil, target: self, action: "clickScan"),
            KxMenuItem("客服", image: nil, target: self, action: "clickServe")
        ])
 
    }
    
    func clickAdd(){
        print("点击了客服1")
    }
    func clickScan(){
        print("点击了客服2")
    }
    func clickServe(){
        print("点击了客服3")
    }
    func talkWith(){
        //代码跳转到会话界面
        let conVC = RCConversationViewController()
        conVC.targetId = "chetaofeng"
        conVC.conversationType = RCConversationType.ConversationType_PRIVATE
        conVC.title = conVC.targetId
        self.navigationController?.pushViewController(conVC, animated: true)
        self.tabBarController?.tabBar.hidden = true
    }
    

    @IBAction func showPopMenu(sender: AnyObject) {
        let items = [
            MenuItem(title:"加好友",iconName:"",glowColor:UIColor.redColor(),index:0),
            MenuItem(title:"扫一扫",iconName:"",glowColor:UIColor.blueColor(),index:1),
            MenuItem(title:"客服",iconName:"",glowColor:UIColor.yellowColor(),index:2)
        ]
        
        let menu = PopMenu(frame:self.view.bounds,items:items)
        menu.menuAnimationType = .Sina
        
        if menu.isShowed {
            return
        }
        
        menu.didSelectedItemCompletion = { (seletedMenu:MenuItem!) -> Void in
            print(seletedMenu.index)
        }
        menu.showMenuAtView(self.view)
    }
}
