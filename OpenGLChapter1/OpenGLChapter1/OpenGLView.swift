//
//  OpenGLView.swift
//  OpenGLChapter1
//
//  Created by ShawnDu on 15/12/11.
//  Copyright © 2015年 Shawn. All rights reserved.
//

import UIKit

class OpenGLView: UIView {

    var eaglLayer: CAEAGLLayer!
    var context: EAGLContext!
    var colorRenderBuffer: GLuint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    func layerClass() -> AnyObject {
        return CAEAGLLayer.self
    }
    
    private func initViews() {
        
    }
    
    private func setupLayer() {
        eaglLayer = CAEAGLLayer(layer: self.layer)
        eaglLayer.opaque = true
    }
    
    private func setupContext() {
        let api = EAGLRenderingAPI.OpenGLES2
        if let context = EAGLContext.init(API: api) {
            if !EAGLContext.setCurrentContext(context) {
                print("Failed to set current opengl context")
                exit(1)
            }
        } else {
            print("failed to initial opengl2.0 context")
            exit(1)
        }
    }
}
