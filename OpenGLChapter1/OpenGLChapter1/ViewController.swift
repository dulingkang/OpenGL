//
//  ViewController.swift
//  OpenGLChapter1
//
//  Created by ShawnDu on 15/12/11.
//  Copyright © 2015年 Shawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var glView: OpenGLView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        glView = OpenGLView.init(frame: self.view.bounds)
        self.view.addSubview(glView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

