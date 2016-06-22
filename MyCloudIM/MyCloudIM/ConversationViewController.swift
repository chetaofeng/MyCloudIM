//
//  ConversationViewController.swift
//  MyCloudIM
//
//  Created by chetaofeng on 16/6/17.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class ConversationViewController: RCConversationViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.enableUnreadMessageIcon = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
