//
//  LLParticleButton.swift
//  AnimationButton
//
//  Created by luo luo on 16/10/2017.
//  Copyright © 2017年 ChangeStrong. All rights reserved.
//

import UIKit

class LLParticleButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var particleLayer:CAEmitterLayer
    
    
    override var isSelected: Bool{
        didSet{
            //执行动画
            executeAni()
        }
    }
    
    override init(frame: CGRect) {
        particleLayer = CAEmitterLayer.init()
        super.init(frame: frame)
        setupExplosion()
    }
    
    required init?(coder aDecoder: NSCoder) {
        particleLayer = CAEmitterLayer.init()
        super.init(coder: aDecoder)
        setupExplosion()
        //        fatalError("init(coder:) has not been implemented")
    }
    

    //发射的动画
    func executeAni(){
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        if isSelected {
            animation.values = [1.5,0.8,1.0,1.2,1.0]
            animation.duration = 0.5
            
            startAnimation()
        } else {
            animation.values = [0.8,1.0]
            animation.duration = 0.4
        }
        
        animation.calculationMode = kCAAnimationCubic
        layer.add(animation, forKey: "transform.scale")
    }
    
    //创建发射层
    func setupExplosion(){
        let explosionCell = CAEmitterCell.init()
        explosionCell.name = "explosion"
        //        设置粒子颜色alpha能改变的范围
        explosionCell.alphaRange = 0.10
        //        粒子alpha的改变速度
        explosionCell.alphaSpeed = -1.0
        //        粒子的生命周期
        explosionCell.lifetime = 0.7
        //        粒子生命周期的范围
        explosionCell.lifetimeRange = 0.3
        
        //        粒子发射的初始速度
        explosionCell.birthRate = 2500
        //        粒子的速度
        explosionCell.velocity = 40.00
        //        粒子速度范围
        explosionCell.velocityRange = 50.00
        
        //        粒子的缩放比例
        explosionCell.scale = 0.03
        //        缩放比例范围
        explosionCell.scaleRange = 0.8
        
        //        粒子要展现的图片
        explosionCell.contents = UIImage(named: "sparkle")?.cgImage
        
        particleLayer.name = "explosionLayer"
        
        //        发射源的形状
        particleLayer.emitterShape = kCAEmitterLayerCircle
        //        发射模式
        particleLayer.emitterMode = kCAEmitterLayerOutline
        //        发射源大小
        particleLayer.emitterSize = CGSize.init(width: 10, height: 10)
        //        发射源包含的粒子
        particleLayer.emitterCells = [explosionCell]
        //        渲染模式
        particleLayer.renderMode = kCAEmitterLayerOldestFirst
        particleLayer.masksToBounds = false
        particleLayer.birthRate = 0
        //        发射位置
        particleLayer.position = CGPoint.init(x: frame.size.width/2, y: frame.size.height/2)
        particleLayer.zPosition = -1
        layer.addSublayer(particleLayer)
        
        
    }
   @objc func stopAnimation(){
        particleLayer.birthRate = 0
    }
    
    func startAnimation(){
        particleLayer.beginTime = CACurrentMediaTime()
        particleLayer.birthRate = 10
        perform(#selector(LLParticleButton.stopAnimation), with: nil, afterDelay: 0.15)
    }
    
    
}
