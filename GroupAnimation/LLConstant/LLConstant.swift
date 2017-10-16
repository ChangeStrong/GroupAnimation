//
//  LLConstant.swift
//  GroupAnimation
//
//  Created by luo luo on 16/10/2017.
//  Copyright © 2017 ChangeStrong. All rights reserved.
//

import UIKit

//常用frame计算
let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenWidth = UIScreen.main.bounds.size.width

func LLWWidth(widget:UIView?) -> CGFloat {
    return (widget?.frame.size.width)!
}
func LLWHeight(widget:UIView?) -> CGFloat {
    return (widget?.frame.size.height)!
}
func LLW_X(widget:UIView?) -> CGFloat {
    return (widget?.frame.origin.x)!
}
func LLW_Y(widget:UIView?) -> CGFloat {
    return (widget?.frame.origin.y)!
}
func LLWTotal_X(widget:UIView?) -> CGFloat {
    return LLW_X(widget: widget) + LLWWidth(widget: widget)
}
func LLWTotal_Y(widget:UIView?) -> CGFloat {
    return LLW_Y(widget: widget) + LLWHeight(widget: widget)
}

class LLConstant: NSObject {

}
