//
//  RegisterTableViewController.swift
//  MyCloudIM
//
//  Created by chetaofeng on 16/6/19.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

class RegisterTableViewController: UITableViewController {
    
    @IBOutlet var loginRequiredTFs: [UITextBox]!
    @IBOutlet weak var userName: UITextBox!
    @IBOutlet weak var password: UITextBox!
    @IBOutlet weak var mailTF: UITextBox!
    @IBOutlet weak var portraitUri: UITextField!
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var answer: UITextField!
    
    var possibleInputs:RegisterInputs = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.hidden = false
        self.title = "注册新用户"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneButtonItemTaped")
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        checkRequiredBy3ndParty()
    }
    
    func doneButtonItemTaped() ->  Void {
        if checkRequired() {
            self.pleaseWait()

            let user         = AVObject(className: "TBL_USER")
            user["userName"] = userName.text
            user["password"] = password.text
            user["mail"]     = mailTF.text
            user["portraitUri"]   = portraitUri.text
            user["question"] = question.text
            user.setObject(answer.text, forKey: "answer")
            
            // 查重
            let query = AVQuery(className: "TBL_USER")
            query.whereKey("userName", equalTo: userName.text)
            query.getFirstObjectInBackgroundWithBlock({ (existUser, error) in
                self.clearAllNotice()

                if existUser != nil {
                    self.navigationItem.rightBarButtonItem?.enabled = false
                    self.errorNotice("用户已存在" )
                    self.userName.becomeFirstResponder()
                }else {
                    user.saveInBackgroundWithBlock({ (succed, error) in
                        if succed {
                            self.successNotice("注册成功")
                            self.navigationController?.popViewControllerAnimated(true)
                        }else{
                            let alert = UIAlertController(title: "注册失败", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                            let doneAction = UIAlertAction(title: "确定", style: .Default, handler: nil)
                            alert.addAction(doneAction)
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                    })
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func checkRequired() -> Bool {
        for textBox in loginRequiredTFs {
            if textBox.text!.isEmpty {
                self.errorNotice("必填项为空")
                return false
            }
        }
       
        let mailPattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", mailPattern)
        guard predicate.evaluateWithObject(mailTF.text) else {
            self.errorNotice("邮箱格式错误")
            return false
        }
        
        return true
    }
    
    func checkRequiredBy3ndParty() -> Bool {
        let v1 = AJWValidator(type: .String)
        v1.addValidationToEnsureMinimumLength(3, invalidMessage: "用户名至少3位")
        v1.addValidationToEnsureMaximumLength(15, invalidMessage: "用户名最大15位")
        self.userName.ajw_attachValidator(v1)
        v1.validatorStateChangedHandler = { (newState:AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
                self.userName.highlightState = UITextBoxHighlightState.Default
                self.possibleInputs.unionInPlace(RegisterInputs.userName)
            case .ValidationStateInvalid:
                self.userName.highlightState = UITextBoxHighlightState.Wrong(v1.errorMessages.first as! String)
                self.possibleInputs.subtractInPlace(RegisterInputs.userName)
            default:
                self.userName.highlightState = UITextBoxHighlightState.Warning("远程验证")
            }
            
            self.navigationItem.rightBarButtonItem?.enabled = self.possibleInputs.isAllOK()
        }

        let v2 = AJWValidator(type: .String)
        v2.addValidationToEnsureMinimumLength(3, invalidMessage: "密码至少3位")
        v2.addValidationToEnsureMaximumLength(15, invalidMessage: "密码最大15位")
        self.password.ajw_attachValidator(v2)
        v2.validatorStateChangedHandler = { (newState:AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
                self.password.highlightState = UITextBoxHighlightState.Default
                self.possibleInputs.unionInPlace(RegisterInputs.password)
            case .ValidationStateInvalid:
                self.password.highlightState = UITextBoxHighlightState.Wrong(v2.errorMessages.first as! String)
                self.possibleInputs.subtractInPlace(RegisterInputs.password)
            default:
                self.password.highlightState = UITextBoxHighlightState.Warning("远程验证")
            }
             self.navigationItem.rightBarButtonItem?.enabled = self.possibleInputs.isAllOK()
        }
        
        
        let v3 = AJWValidator(type: .String)
        v3.addValidationToEnsureValidEmailWithInvalidMessage("邮箱格式不正确")
        self.mailTF.ajw_attachValidator(v3)
        v3.validatorStateChangedHandler = { (newState:AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
                self.mailTF.highlightState = UITextBoxHighlightState.Default
                self.possibleInputs.unionInPlace(RegisterInputs.mail)
            case .ValidationStateInvalid:
                self.mailTF.highlightState = UITextBoxHighlightState.Wrong(v3.errorMessages.first as! String)
                self.possibleInputs.subtractInPlace(RegisterInputs.mail)
            default:
                self.mailTF.highlightState = UITextBoxHighlightState.Warning("远程验证")
            }
            
             self.navigationItem.rightBarButtonItem?.enabled = self.possibleInputs.isAllOK()
        }
        
        return true
    }
}
