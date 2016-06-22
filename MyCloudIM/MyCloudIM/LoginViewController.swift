//
//  LoginViewController.swift
//  MyCloudIM
//
//  Created by chetaofeng on 16/6/18.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius:CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = (newValue > 0)
        }
    }
}

class LoginViewController: UIViewController,JSAnimatedImagesViewDataSource,RCIMUserInfoDataSource {

    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var wallPaper: JSAnimatedImagesView!
    @IBOutlet weak var userName: UITextBox!
    @IBOutlet weak var password: UITextBox!
    @IBOutlet weak var loginBtn: UIButton!
    
    var loginInputs:LoginInputs = [] //登录控件组合
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        self.wallPaper.dataSource = self
        
        validate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        //通过设置StackView的方向设置动画效果
        UIView.animateWithDuration(0.5) {
            self.loginStackView.axis = .Vertical
        }
    }
    
    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
        return 3
    }
    
    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named: "image\(index + 1)")
    }

    @IBAction func loginBtnTapped(sender: AnyObject) {
        let query = AVQuery(className: "TBL_USER")
        query.whereKey("userName", equalTo: userName.text)
        query.whereKey("password", equalTo: password.text)
        
        self.pleaseWait()
    
        query.getFirstObjectInBackgroundWithBlock { (currentUser, error) in
            self.clearAllNotice()
            if currentUser != nil {
                self.successNotice("登录成功")
                
                RCIM.sharedRCIM().userInfoDataSource = self  // 设置用户信息提供者
                
                self.performSegueWithIdentifier("loginSucc", sender: self)
            }else{
                if error.code == 6 {
                    self.errorNotice("网络异常,请重试")
                }else {
                    self.errorNotice("用户名或密码错误")
                }
            }
        }
    }
    
    
    func validate() -> Void {
        ValidatorHelper.validateMinLength(3, msg: "用户名至少3位", textBox: userName)
//        loginBtn.enabled = loginInputs.isAllLoginOK()
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
    }
    
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        let userInfo = RCUserInfo()
        
        let query = AVQuery(className: "TBL_USER")
        query.whereKey("userName", equalTo: userId)
        query.getFirstObjectInBackgroundWithBlock({ (existUser, error) in
            if existUser != nil {
                userInfo.name =  existUser.objectForKey("userName") as! String
                userInfo.portraitUri = existUser.objectForKey("portraitUri") as! String
            }else {
                print(error)
            }
        })
        
        return completion(userInfo)
    }
}
