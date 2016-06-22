//
//  AppDelegate.swift
//  MyCloudIM
//
//  Created by chetaofeng on 16/6/14.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func connectServer(completion:() -> Void) {
        // 初始化AppKey
        RCIM.sharedRCIM().initWithAppKey("bmdehs6pdo4us")
        
        // 用Token测试连接
        RCIM.sharedRCIM().connectWithToken("kXYcfb0UbTmagoJFU3hE2e2e8AIuLTE9cSIJq8PMTt7jHFDmQJpF4Ekpa/T1rwd6vjtrx2tAWWIoay6lev19cUnzTMGDjB6i", success: { (_) in
                let currentUserInfo = RCUserInfo(userId: "chetaofeng", name: "天行贱", portrait: "http://p1.image.hiapk.com/uploads/allimg/130927/23-13092G51228-51.jpg")
                RCIMClient.sharedRCIMClient().currentUserInfo = currentUserInfo
            
                //在主线程中异步执行刷新界面等其他操作
                dispatch_async(dispatch_get_main_queue(), { 
                    completion()
                })
            }, error: { (_) in
                print("连接失败")
            }) { 
                 print("token不正确或已失效")
        }
    }
 
    // appkey:bmdehs6pdo4us         App Secret:EzzbIBytE6Sw
    //{"code":200,"userId":"che","token":"BobctVIbQ3eMRINLx/9mB+2e8AIuLTE9cSIJq8PMTt7jHFDmQJpF4N0/QEGD6aDz9+RCSSlK7fnLcUg9C03c4A=="}
    //{"code":200,"userId":"cheche","token":"lh+ABnaaLmfMs1PTpDwLTshcSSuP2wnuS1T05hmHVXI3dQGLzM0jfHftWuh9d7QLtJ5R/kK+T/h+o1CNYxn31A=="}
    //{"code":200,"userId":"admin","token":"edvQLGN/x5uDcRwMWCSQ2vY0gT7IerK2crEQqjquAxVPtjvQHDaoWviNCkOh6Ulx6Br9SquPAkF4I2Re6yWVkQ=="}
    //{"code":200,"userId":"chetaofeng","token":"kXYcfb0UbTmagoJFU3hE2e2e8AIuLTE9cSIJq8PMTt7jHFDmQJpF4Ekpa/T1rwd6vjtrx2tAWWIoay6lev19cUnzTMGDjB6i"}
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        RCIM.sharedRCIM().userInfoDataSource = self  // 设置用户信息提供者
        
        //获取LeanCloud授权
        //chetaofeng@163.com    54Ctf123./
        AVOSCloud.setApplicationId("d2oiSScgPKgWKhDNGG9xCNkC-gzGzoHsz", clientKey: "ozbRCRYOXVm5pltH2voFjN9W")
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
     
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
        
    }


//    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
//        let userInfo = RCUserInfo()
//        
//        let query = AVQuery(className: "T_USER")
//        query.whereKey("userName", equalTo: userId)
//        query.getFirstObjectInBackgroundWithBlock({ (existUser, error) in
//            if existUser != nil {
//                userInfo.name =  existUser.objectForKey("userName") as! String
//                userInfo.portraitUri = "http://p1.image.hiapk.com/uploads/allimg/130927/23-13092G51228-51.jpg"
//            }else {
//                print(error)
//            }
//        })
//        
//        return completion(userInfo)
//    }
}

