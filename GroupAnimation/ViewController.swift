//
//  ViewController.swift
//  GroupAnimation
//
//  Created by luo luo on 16/10/2017.
//  Copyright © 2017 ChangeStrong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var ballView:ButtonExpandedView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ballView = ButtonExpandedView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), buttonCounts: 3,buttonWidhtAndHeight:80)
        ballView.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)
        self.view.addSubview(ballView)
        ballView.buttonClickBlcok = {(btn:UIButton) ->Void in
            print("clickBlock:\(btn.tag)")
            self.ballView.startAnimation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

