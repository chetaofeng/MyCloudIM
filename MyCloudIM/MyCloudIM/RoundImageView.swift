//
//  RoundImageView.swift
//  MyCloudIM
//
//  Created by chetaofeng on 16/6/18.
//  Copyright © 2016年 gsunis. All rights reserved.
//

import UIKit

@IBDesignable
class RoundImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    @IBInspectable var radius:CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = (radius > 0)
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor:UIColor?  {
        didSet{
            self.layer.borderColor = borderColor?.CGColor
        }
    }
}
