//
//  ValidatorHelper.swift
//  MyCloudIM
//
//  Created by chetaofeng on 16/6/21.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import Foundation

class ValidatorHelper {
    
    static func validateMinLength(length:UInt,msg:String,textBox:UITextBox) -> Bool {
        var isOk = false
        let v = AJWValidator(type: .String)
        v.addValidationToEnsureMinimumLength(length, invalidMessage: msg)
        textBox.ajw_attachValidator(v)
        v.validatorStateChangedHandler = { (newState:AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
                textBox.highlightState = UITextBoxHighlightState.Default
                
                isOk = true
            case .ValidationStateInvalid:
                textBox.highlightState = UITextBoxHighlightState.Wrong(v.errorMessages.first as! String)
                isOk = false
            default:
                textBox.highlightState = UITextBoxHighlightState.Warning("远程验证")
                isOk = false
            }
        }
        return isOk
    }
    
    static func validateMaxLength(length:UInt,msg:String,tf:UITextBox) -> Bool {
        var isOk = false
        let v = AJWValidator(type: .String)
        v.addValidationToEnsureMaximumLength(length, invalidMessage: msg)
        tf.ajw_attachValidator(v)
        v.validatorStateChangedHandler = { (newState:AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
                tf.highlightState = UITextBoxHighlightState.Default
                isOk = true
            case .ValidationStateInvalid:
                tf.highlightState = UITextBoxHighlightState.Wrong(v.errorMessages.first as! String)
                isOk = false
            default:
                tf.highlightState = UITextBoxHighlightState.Warning("远程验证")
                isOk = false
            }
        }
        return isOk
    }
    
    static func validateMail(length:UInt,msg:String,tf:UITextBox) -> Bool {
        var isOk = false
        let v = AJWValidator(type: .String)
        v.addValidationToEnsureValidEmailWithInvalidMessage(msg)
        tf.ajw_attachValidator(v)
        v.validatorStateChangedHandler = { (newState:AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
                tf.highlightState = UITextBoxHighlightState.Default
                isOk = true
            case .ValidationStateInvalid:
                tf.highlightState = UITextBoxHighlightState.Wrong(v.errorMessages.first as! String)
                isOk = false
            default:
                tf.highlightState = UITextBoxHighlightState.Warning("远程验证")
                isOk = false
            }
        }
        return isOk
    }
}