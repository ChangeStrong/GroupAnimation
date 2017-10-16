//
//  ButtonExpandedView.swift
//  GroupAnimation
//
//  Created by luo luo on 16/10/2017.
//  Copyright © 2017 ChangeStrong. All rights reserved.
//

import UIKit





class ButtonExpandedView: UIView,CAAnimationDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var buttonClickBlcok:(UIButton)->Void = {(btn:UIButton) ->Void in
        
    }
    
    
    let buttonImages = ["callphone","ciclrer","iD"]
    var buttons = Array<UIButton>.init()
    
    //按钮的宽和高
    var buttonWidth:CGFloat!
    var radius:CGFloat!
    
    init(frame: CGRect, buttonCounts:UInt, buttonWidhtAndHeight:CGFloat) {
        super.init(frame: frame)
        //半径可调
        radius = frame.size.height/3.0
        buttonWidth = buttonWidhtAndHeight
        
        if buttonCounts > 3 {
            print("it is not support button counts !!!")
        }
        
        //底部中心button
        let button0 = self.createButton()
        button0.center = CGPoint.init(x: LLWWidth(widget: self)/2.0, y: LLWHeight(widget: self)-buttonWidth/2.0)
        button0.tag = 0
        button0.setBackgroundImage(UIImage.init(named: "add"), for: UIControlState.normal)
        self.addSubview(button0)
        
        var counts:UInt!
        counts = buttonCounts == 2 ? 3 : buttonCounts
        for nums in 1...counts {
            if buttonCounts == 2 && nums == 1 {
                //为两个时使用侧面两个
                continue
            }
            //第一个
            let button = self.createButton()
            
            button.tag = Int(nums)
            //            button.setBackgroundImage(UIImage.init(named: buttonImages[Int(nums-1)]), for: UIControlState.normal)
            button.setImage(UIImage.init(named: buttonImages[Int(nums-1)]), for: UIControlState.normal)
            button.isHidden = true
            self.addSubview(button)
            buttons.append(button)
            
            switch nums {
            case 1:
                
                button.center = CGPoint.init(x: LLWWidth(widget: self)/2.0, y: LLWHeight(widget: self) - radius)
                break
            case 2:
                
                let X = LLWWidth(widget: self)/2.0 + radius*cos(self.angleConvertRadian(angle: 60))
                let Y = LLWHeight(widget: self) - radius*cos(self.angleConvertRadian(angle: 30))
                button.center = CGPoint.init(x: X, y: Y)
                break
            case 3:
                let X = LLWWidth(widget: self)/2.0 - radius*cos(self.angleConvertRadian(angle: 60))
                let Y = LLWHeight(widget: self) - radius*cos(self.angleConvertRadian(angle: 30))
                button.center = CGPoint.init(x: X, y: Y)
                break
                
            default: break
                
            }
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    //开始动画
    func startAnimation() -> Void {
        for button in buttons {
            //动画路径
            let mainButtonPath = CGMutablePath.init()
            mainButtonPath.move(to: CGPoint.init(x: (LLWWidth(widget: self)-buttonWidth)/2.0, y: LLWHeight(widget: self)))
            print("width:\(LLW_Y(widget: button))")
            //默认layer上面的锚点为(0.5,0.5)所以layer最终停留的位置如下
            mainButtonPath.addLine(to: CGPoint.init(x: LLW_X(widget: button)+buttonWidth/2.0, y: LLW_Y(widget: button)+buttonWidth/2.0))
            //            mainButtonPath.closeSubpath() //连线闭环
            let animation = self.createAnimation(path: mainButtonPath)
            
            button.layer.add(animation, forKey: "LLGroupAnimation")
        }
    }
    //结束动画
    func stopAnimation() -> Void {
        for button in buttons {
            button.layer.removeAnimation(forKey: "LLGroupAnimation")
        }
    }
    
    
    //动画创建
    func createAnimation(path:CGPath) -> CAAnimationGroup {
        // 实例化一个组动画对象
        let groupAnimation = CAAnimationGroup()
        
        // 创建旋转的动画
        let basicRotation = CABasicAnimation(keyPath: "transform.rotation.z")
        basicRotation.toValue = Float.pi * 2
        
        
        // 创建缩放的动画
        let basicScale = CABasicAnimation(keyPath: "transform.scale")
        basicScale.fromValue = 0.2
        basicScale.toValue = 1.0
        
        //路径动画
        let keyFrameAnimation = CAKeyframeAnimation(keyPath:"position")
        keyFrameAnimation.path = path
        
        //将旋转、缩放、移动的动画添加到组动画中
        groupAnimation.animations = [basicRotation,basicScale,keyFrameAnimation]
        //组动画重复次数
        groupAnimation.repeatCount = 1
        //组动画时长
        groupAnimation.duration = 3
        // 结束保持最后状态
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.delegate = self
        //匀速
        groupAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        //动画执行完不移除和fillmode都要设置
        groupAnimation.isRemovedOnCompletion = false
        
        return groupAnimation
    }
    
    func createButton() -> UIButton {
        
        let mainButton = LLParticleButton.init(frame: CGRect.init(x: 0, y: 0, width: buttonWidth, height: buttonWidth))
        mainButton.addTarget(self, action: #selector(ButtonExpandedView.buttonClick(sendor:)), for: UIControlEvents.touchUpInside)
        mainButton.backgroundColor = UIColor.red
        mainButton.layer.cornerRadius = buttonWidth/2.0
        mainButton.layer.masksToBounds = true
        return mainButton
        
    }
    
    //点击事件
  @objc  func buttonClick(sendor:UIButton?) -> Void {
        print("clickTag:\(String(describing: sendor?.tag))")
        sendor?.isSelected = !(sendor?.isSelected)!
        switch Int((sendor?.tag)!) {
        case 0:
            self.buttonClickBlcok(sendor!)
            //            self.startAnimation()
            print("")
            break
            
        default: break
            
        }
        
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        print("animationDidStart")
        
        for button in buttons {
            if button.isHidden {
                button.isHidden = false
            }
        }
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animationDidStop")
        self.stopAnimation()
    }
    //角度转弧度
    func angleConvertRadian(angle:CGFloat) -> CGFloat {
        return angle*CGFloat(Float.pi)/180.0
    }
}
