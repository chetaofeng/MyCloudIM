//
//  Inputs.swift
//  MyCloudIM
//
//  Created by chetaofeng on 16/6/20.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import Foundation

struct RegisterInputs:OptionSetType {
    let rawValue: Int
    
    static let userName = RegisterInputs(rawValue: 1 << 0)
    static let password = RegisterInputs(rawValue: 1 << 1)
    static let mail     = RegisterInputs(rawValue: 1 << 2)
}

extension RegisterInputs {
    func isAllOK() -> Bool {
        // 比较方式一
        //return self == [.userName,.password,.mail]
        
        // 比较方式二
        //return self.rawValue == 0b111
        
        // 比较方式三
        let count = 3 //选项个数
        var found = 0 //找到的个数
        for time in 0..<count where self.contains(RegisterInputs(rawValue: 1 << time)) {
            found += 1
        }
        
        return found == count  //是否全部找到
    }
}

struct LoginInputs:OptionSetType {
    let rawValue: Int
    
    static let userName = LoginInputs(rawValue: 1 << 0)
    static let password = LoginInputs(rawValue: 1 << 1)
   }

extension LoginInputs {
    func isAllLoginOK() -> Bool {
        let count = 2
        var found = 0 //找到的个数
        for time in 0..<count where self.contains(LoginInputs(rawValue: 1 << time)) {
            found += 1
        }
        
        return found == count
    }
}
